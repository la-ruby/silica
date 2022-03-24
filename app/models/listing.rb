# frozen_string_literal: true

class Listing < ApplicationRecord
  has_rich_text :description
  scope :showables, -> { where(listed: 'true') }

  belongs_to :project
  has_many :bids
  has_many :users, through: :bids

  def self.search(options = {})
    relation = Listing.showables

    relation = relation.where("baths >= #{options[:baths]}") if begin
      Integer(options[:baths])
    rescue StandardError
      nil
    end

    relation = relation.where("beds >= #{options[:beds]}") if begin
      Integer(options[:beds])
    rescue StandardError
      nil
    end

    relation = relation.where("address ILIKE '%#{options[:q]}%'") if options[:q].present?

    relation = relation.order('price ASC')  if options[:sort] == '1'
    relation = relation.order('price DESC') if options[:sort] == '2'

    [relation, relation.page(options[:page]).per(10)]
  end
end
