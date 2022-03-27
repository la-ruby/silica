# frozen_string_literal: true

# Cache Contact Count Job
class CacheContactCountJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    count = JSON.parse(
      SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY2'])
        .client.marketing.lists.get(query_params: {}).body
    )['result']
                .select { |x| x['id'] == SENDGRID_MARKETING_LIST_ID }
                .dig(0, 'contact_count')
    Rails.cache.write('contact_count_at_sendgrid', count)
  end
end
