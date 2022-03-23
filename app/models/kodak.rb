# frozen_string_literal: true

# The Kodak class
class Kodak < ApplicationRecord
  belongs_to :project

  has_one_attached :pic do |attachable|
    attachable.variant :small, resize_to_limit: [300, 300]
    attachable.variant :large, resize_to_limit: [1440, 900]
  end
end
