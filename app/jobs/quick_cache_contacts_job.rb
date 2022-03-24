# frozen_string_literal: true

require 'open-uri'

class QuickCacheContactsJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY2'])
    response = sg.client.marketing.contacts.get()
    response.parsed_body[:result].select{|x| x[:list_ids].include?(SENDGRID_MARKETING_LIST_ID) }.each do |item|
      Contact.create({
          first_name: item[:first_name],
          last_name: item[:last_name],
          phone_mobile: item.dig(:custom_fields,:phone_mobile),
          phone_work: item.dig(:custom_fields,:phone_work),
          email: item.dig(:email),
          investing_location: item.dig(:custom_fields, :investing_location),
          sendgrid_created_at: item.dig(:created_at),
          sendgrid_created_at_searchable: DateTime.parse( item.dig(:created_at) ).strftime("%m/%d"),
        }) unless Contact.find_by_email(item[:email])
    end
    Rails.cache.write("contact_count_at_sendgrid", Contact.count)
  end
end
