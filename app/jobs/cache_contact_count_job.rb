# frozen_string_literal: true

class CacheContactCountJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    count = JSON.parse(
      SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY2'])
        .client.marketing.lists.get(query_params: {}).body)
              .dig('result')
              .select{|x| x["id"] == "bc6acbc2-b12c-49d8-beee-31fc9908ba4b" }
              .dig(0, 'contact_count')
    Rails.cache.write("contact_count_at_sendgrid", count)
  end
end
