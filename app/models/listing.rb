# frozen_string_literal: true

# Listing Model
class Listing < ApplicationRecord
  has_rich_text :description
  scope :showables, -> { where(listed: 'true') }

  belongs_to :project
  has_many :bids
  has_many :users, through: :bids

  def self.search(options = {})
    relation = Listing.showables

    relation =  Listing.listing_where(relation, "baths >= #{options[:baths]}", options[:baths])
    relation =  Listing.listing_where(relation, "beds >= #{options[:beds]}", options[:beds])
    relation = relation.where("address ILIKE '%#{options[:q]}%'") if options[:q].present?
    relation = Listing.listing_order(relation, options)

    [relation, relation.page(options[:page]).per(10)]
  end

  def self.listing_where(relation, where_state, where_option)
    relation.where(where_state) if begin
      Integer(where_option)
    rescue StandardError
      nil
    end
    relation
  end

  def self.listing_order(relation, options)
    return relation unless options[:sort]

    case options[:sort]
    when '1'
      relation.order('price ASC')
    when '2'
      relation.order('price DESC')
    end
    relation
  end
end
