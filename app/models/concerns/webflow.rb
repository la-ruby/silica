# frozen_string_literal: true

# Webflow module
module Webflow
  extend ActiveSupport::Concern

  included do
    scope :patchable, -> { joins(:listing).where('listings.webflow_id IS NOT NULL') }
    scope :postable, -> { joins(:listing).where('listings.webflow_id IS NULL') }

    # :reek:DuplicateMethodCall
    def send_to_webflow
      Rails.logger.info "Sending project #{id} to webflow"
      WebflowClient.upload(
        "https://api.webflow.com/collections/#{WEBFLOW_COLLECTION}/items",
        :post,
        {
          'fields' => {
            'name' => listing.title,
            'post-address' => combined_address_with_zip[0..39],
            'property-about' => listing.legacy_description.presence || '-',
            'property-main-image-page' => 'https://dummyimage.com/600x400/000/fff&text=testing',
            'post-market-url' => "#{APOLLO_MARKETPLACE_FULL_DOMAIN}/listings/#{listing.id}",
            'post-price' => pretty_format_money(listing.suggested_price),
            'post-display-price-2' => 'true',
            'property-location' => WEBFLOW_LOCATION_CODE,
            'property-agent' => APOLLO_PURCHASER_NAME,

            # forced to send these:
            # "problems":["Field '_archived': Field is required"...
            # ...
            '_archived' => false,
            '_draft' => false,
            'property-main-image-thumbnail-card' => 'https://dummyimage.com/600x400/000/fff&text=testing',
            'property-short-description-page' => listing.legacy_description.presence || '-',
            'property-excerpt-card-featured' => '-'
          }
        }
      )
    end

    def send_update_to_webflow
      Rails.logger.info "Sending update for project #{id} to webflow"
      WebflowClient.upload(
        "https://api.webflow.com/collections/#{WEBFLOW_COLLECTION}/items/#{listing.webflow_id}",
        :patch,
        {
          'fields' => {
            'name' => listing.title,
            'post-address' => combined_address_with_zip,
            'property-about' => listing.legacy_description,
            'property-main-image-page' => 'https://dummyimage.com/600x400/000/fff&text=testing',
            'post-market-url' => "#{APOLLO_MARKETPLACE_FULL_DOMAIN}/listings/#{listing.id}",
            'post-price' => pretty_format_money(listing.suggested_price),
            'post-display-price-2' => 'true',
            'property-location' => WEBFLOW_LOCATION_CODE,
            'property-agent' => WEBFLOW_PROPERTY_AGENT
          }
        }
      )
    end
  end
end
