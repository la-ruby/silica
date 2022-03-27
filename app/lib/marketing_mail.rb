# frozen_string_literal: true

# Marketing Mail
class MarketingMail
  include PrettyDate
  include PrettyMoney

  # This method was done in a rush and needs refactoring
  def perform(project_id:)
    project = Project.find(project_id)
    blurb = project.listing.title.presence || '-'
    segment_id = (project.north_carolina? ? APOLLO_NC_MAILING_LIST : APOLLO_UTAH_MAILING_LIST)
    design = Net::HTTP.get_response(URI("https://api.sendgrid.com/v3/designs/#{SENDGRID_DESIGN}"),
                                    { 'Authorization' => "Bearer #{SENDGRID_API_KEY2}" }).body

    plain_content = JSON.parse(design)['plain_content']
    html_content = JSON.parse(design)['html_content']

    picture_url = ''
    picture_path = begin
      Rails.application.routes.url_helpers.rails_blob_path(project.primary_or_first_kodak,
                                                           only_path: true)
    rescue StandardError
      nil
    end
    picture_url = "#{APOLLO_PORTAL_FULL_DOMAIN}#{picture_path}" if project.marketplace_kodaks.count.positive?

    # TODO: refactor substitutions
    plain_content.gsub! '{{blurb}}', blurb
    plain_content.gsub! "https://#{APOLLO_NAKED_DOMAIN}/deal?id=", "http://#{APOLLO_MARKETPLACE_DOM}/listings/"
    plain_content.gsub! '{{id}}', project.listing.id.to_s
    plain_content.gsub! '{{suggested}}', pretty_format_money(project.listing.suggested_price)
    plain_content.gsub! '{{sqft}}', begin
      project.listing.sqft.to_s
    rescue StandardError
      ''
    end
    plain_content.gsub! '{{year}}', begin
      project.listing.year.to_s
    rescue StandardError
      ''
    end
    plain_content.gsub! '{{bed}}', begin
      project.listing.beds.to_s
    rescue StandardError
      ''
    end
    plain_content.gsub! '{{bath}}', begin
      project.listing.baths.to_s
    rescue StandardError
      ''
    end
    plain_content.gsub! '{{misc}}', project.listing.description.to_s
    plain_content.gsub! '{{street}}', project.listing.project.street.to_s
    plain_content.gsub! '{{city}}', project.listing.project.city.to_s
    plain_content.gsub! '{{state}}', project.listing.project.state.to_s
    plain_content.gsub! '{{walkthroughDate}}', project.listing.walkthrough_date.to_s
    plain_content.gsub! '{{walkthroughTime}}', project.listing.walkthrough_time.to_s
    plain_content.gsub! "See more #{COMPANY_LC} deals! ( https://#{APOLLO_NAKED_DOMAIN}/ )",
                        "See more #{COMPANY_LC} deals! ( https://#{APOLLO_MARKETPLACE_DOM}/ )"
    plain_content.gsub! "https://#{APOLLO_NAKED_DOMAIN}/", "https://#{APOLLO_MARKETPLACE_DOM}/listings"
    plain_content.gsub! '{{pictureUrl}}', picture_url

    html_content.gsub! '{{blurb}}', blurb
    html_content.gsub! "https://#{APOLLO_NAKED_DOMAIN}/deal?id=", "http://#{APOLLO_MARKETPLACE_DOM}/listings/"
    html_content.gsub! '{{id}}', project.listing.id.to_s
    html_content.gsub! '{{suggested}}', pretty_format_money(project.listing.suggested_price)
    html_content.gsub! '{{sqft}}', begin
      project.listing.sqft.to_s
    rescue StandardError
      ''
    end
    html_content.gsub! '{{year}}', begin
      project.listing.year.to_s
    rescue StandardError
      ''
    end
    html_content.gsub! '{{bed}}', begin
      project.listing.beds.to_s
    rescue StandardError
      ''
    end
    html_content.gsub! '{{bath}}', begin
      project.listing.baths.to_s
    rescue StandardError
      ''
    end
    html_content.gsub! '{{misc}}', project.listing.description.to_s
    html_content.gsub! '{{street}}', project.listing.project.street.to_s
    html_content.gsub! '{{city}}', project.listing.project.city.to_s
    html_content.gsub! '{{state}}', project.listing.project.state.to_s
    html_content.gsub! '{{walkthroughDate}}', apollo_date2(project.listing.walkthrough_date).to_s
    html_content.gsub! '{{walkthroughTime}}', apollo_date4(project.listing.walkthrough_time).to_s
    html_content.gsub! "See more #{COMPANY_LC} deals! ( https://#{APOLLO_NAKED_DOMAIN}/ )",
                       "See more #{COMPANY_LC} deals! ( https://#{APOLLO_MARKETPLACE_DOM}/ )"
    html_content.gsub! "https://#{APOLLO_NAKED_DOMAIN}/", "https://#{APOLLO_MARKETPLACE_DOM}/listings"
    html_content.gsub! '{{pictureUrl}}', picture_url
    # /TODO: refactor substitutions

    sg = SendGrid::API.new(api_key: SENDGRID_API_KEY2)
    data = {
      name: "#{COMPANY}WebAppSendout",
      send_to: { segment_ids: [segment_id] }, # TODO: swap with real ids
      email_config: {
        plain_content: plain_content, # TODO: swap with real content
        html_content: html_content,  # TODO: swap with real content
        subject: blurb,
        sender_id: SENGRID_SENDER_ID.to_i,
        suppression_group_id: SENDGRID_SUPPRESSION_GROUP_ID.to_i
      }
    }
    response = sg.client.marketing.singlesends.post(request_body: data)
    Rails.logger.info response.status_code
    Rails.logger.info response.headers
    Rails.logger.info response.body

    id = JSON.parse(response.body)['id']
    raise 'Step1OfSingleSendFailed' unless id

    response = sg.client.marketing._("singlesends/#{id}/schedule").put(request_body: { send_at: 'now' })
    response.body
  end
end
