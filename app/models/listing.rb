# frozen_string_literal: true

# The Listing class
class Listing < ApplicationRecord
  has_rich_text :description
  scope :showables, -> { where(listed: 'true') }

  belongs_to :project
  has_many :bids
  has_many :users, through: :bids

  # rubocop: disable Metrics/AbcSize
  def self.search(options = {})
    relation = Listing.showables

    relation = relation.where("baths >= #{options[:baths]}")
    rescue StandardError
      nil
    end

    relation = relation.where("address ILIKE '%#{options[:q]}%'") 

    relation = options[:sort] == '1' ? relation.order('price ASC') : relation.order('price DESC')

    [relation, relation.page(options[:page]).per(10)]
  end
  # rubocop: enable Metrics/AbcSize
end
