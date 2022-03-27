# frozen_string_literal: true

module DocuSign
  # Envelope Request Body Alternative
  class EnvelopeRequestBodyAlternative
    def initialize(options = {})
      @options = options
    end

    def to_json(*_args)
      {
        'templateId' => @options[:template_id],
        'status' => 'sent',
        'templateRoles' => roles
      }.to_json
    end

    def roles
      roles = [first_seller_role, company_buyer_role]
      roles.concat([second_seller_role]) if @options[:second_seller_mode]
      roles
    end

    def first_seller_role
      {
        'name' => @options[:first_seller_name],
        'email' => @options[:first_seller_email],
        'roleName' => 'Homeowner',
        'clientUserId' => '1001'
      }
    end

    def second_seller_role
      {
        'name' => @options[:second_seller_name],
        'email' => @options[:second_seller_email],
        'roleName' => 'Second Homeowner',
        'clientUserId' => '1002'
      }
    end

    def company_buyer_role
      {
        'name' => APOLLO_PURCHASER_NAME,
        'email' => APOLLO_PURCHASER_EMAIL,
        'roleName' => COMPANY,
        'clientUserId' => '1000'
      }.merge(tabs)
    end

    def tabs
      { 'tabs' => radio_group_tabs.merge(text_tabs) }
    end

    def text_tabs
      {
        'textTabs' => pairs.map { |pair| { 'tabLabel' => pair[0], 'value' => pair[1] } }
      }
    end

    def pairs
      [
        %w[addendumNumber 1], # ..Drafts(versions) should only happen in our system and the only "version" the seller should see in docusign is "Version 1"
        ['offerDate', @options[:offer_date]],
        ['buyer', APOLLO_PURCHASER_NAME],
        ['seller', @options[:seller_name]],
        ['secondName', @options[:second_seller_name]],
        ['address', @options[:address]],
        ['addendumTerms', @options[:addendum_terms]],
        ['deadlineChanges', @options[:deadline_changes]],
        ['addendumDeadlineDate', @options[:addendum_deadline_date]],
        ['addendumDeadlineTime', @options[:addendum_deadline_time]]
      ]
    end

    def radio_group_tabs
      {
        'radioGroupTabs' => [
          {
            'groupName' => 'addendumType',
            'radios' => [
              {
                'selected' => 'true',
                'value' => 'addendum'
              }
            ]
          },
          {
            'groupName' => 'deadlinesChanged',
            'radios' => [
              {
                'selected' => 'true',
                'value' => @options[:deadlines_changed]
              }
            ]
          }
        ]
      }
    end
  end
end
