# frozen_string_literal: true

module DocuSign
  class EnvelopeRequestBody
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
        ['purchasePrice', @options[:purchase_price]],
        ['sellerName', @options[:seller_name]],
        ['sellerEmail', @options[:seller_email]],
        ['sellerPhone', @options[:seller_phone]],
        ['secondName', @options[:second_name]],
        ['secondEmail', @options[:second_email]],
        ['secondPhone', @options[:second_phone]],
        ['address', @options[:address]],
        ['earnestMoney', @options[:earnest_money]],
        ['agreementDate', @options[:agreement_date]],
        ['settlementDate', @options[:settlement_date]],
        ['inspectionPeriodDate', @options[:inspection_period_date]],
        ['possessionDate', @options[:possession_date]],
        ['additionalPaymentTerms', @options[:additional_payment_terms]],
        ['notes', @options[:notes]],
        ['purchaserName', APOLLO_PURCHASER_NAME],
        ['purchaserEmail', APOLLO_PURCHASER_EMAIL],
        ['purchaserPhone', APOLLO_PURCHASER_PHONE],
        ['legalDescription', @options[:legal_description]],
        ['titleCompany', @options[:title_company]]
      ]
    end

    def radio_group_tabs
      {
        'radioGroupTabs' => [
          {
            'groupName' => 'realEstateProfessional',
            'radios' => [
              {
                'selected' => 'true',
                'value' => @options[:real_estate_professional]
              }
            ]
          },
          {
            'groupName' => 'closingCostsPaidBy',
            'radios' => [
              {
                'selected' => 'true',
                'value' => @options[:closing_costs_paid_by]
              }
            ]
          }
        ]
      }
    end
  end
end
