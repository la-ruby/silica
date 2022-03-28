# frozen_string_literal: true

require 'open-uri'

class CacheContactsJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY2'])
    response = sg.client.marketing.contacts.exports.post(request_body: { list_ids: [ SENDGRID_MARKETING_LIST_ID ], file_type: 'json'})
    id = response.parsed_body.dig(:id)
    reponse = nil
    40.times do
      response = sg.client.marketing.contacts.exports._(id).get
      Rails.logger.info "sleep 1"
      sleep 1 unless Rails.env.test?
      break if response.parsed_body[:status] == "ready"
    end

    url = response.parsed_body.dig(:urls, 0)
    ActiveRecord::Base.connection.execute("TRUNCATE contacts")

    download = Net::HTTP.get(URI(url))
    Contact.insert_all(
      download.each_line.map do |x|
        parsed = JSON.parse(x)
        {
          first_name: parsed.dig('first_name'),
          last_name: parsed.dig('last_name'),
          phone_mobile: parsed.dig('custom_fields','phone_mobile'),
          phone_work: parsed.dig('custom_fields','phone_work'),
          email: parsed.dig('email'),
          investing_location: parsed.dig('custom_fields', 'investing_location'),
          sendgrid_created_at: parsed.dig('created_at'),
          sendgrid_created_at_searchable: DateTime.parse( parsed.dig('created_at') ).strftime("%m/%d"),
        }
      end
    )
  end
end
