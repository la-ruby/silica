# frozen_string_literal: true

class Listing < ApplicationRecord
  has_rich_text :description
  scope :showables, -> { where(listed: 'true') }

  belongs_to :project
  has_many :bids
  has_many :users, through: :bids

  after_update :activity_tab_updates

  def activity_tab_updates
    if silica_attribute_toggled?('listed', previous_changes)
      Event.create(
        category: ((previous_changes["listed"][1] == true || previous_changes["listed"][1] == 'true') ? 'listing_added' : 'listing_removed'),
        timestamp: Time.now,
        record_id: project.id,
        record_type: 'Project',
        inventor_id: listed_whodunnit)
    end
  end

  def silica_attribute_toggled?(the_attribute, the_previous_changes)
    if the_previous_changes.has_key?(the_attribute) && 
      (the_previous_changes[the_attribute][1] != nil) && # setting to nil doesnt cout, its used during testing
      the_previous_changes[the_attribute][0] != the_previous_changes[the_attribute][1]
      true
    end
  end

  def self.search(options = {})
    relation = Listing.showables

    if (Integer(options[:baths]) rescue nil)
      relation = relation.where("baths >= #{options[:baths]}")
    end

    if (Integer(options[:beds]) rescue nil)
      relation = relation.where("beds >= #{options[:beds]}")
    end

    if options[:q].present?
      relation = relation.where("address ILIKE '%#{options[:q]}%'")
    end

    relation = relation.order('price ASC')  if options[:sort] == '1'
    relation = relation.order('price DESC') if options[:sort] == '2'

    [ relation, relation.page(options[:page]).per(10) ]
  end
end
