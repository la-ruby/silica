# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bids
  has_many :listings, through: :bids

  devise :database_authenticatable

  def staff?
    email == APOLLO_ADMIN_LOGIN
  end

  # nickname shown in top nav
  def nick
    email.split('@').first.gsub(/\W/,'_').titleize
  end

  def permission?(string)
    permissions.include?(string)
  end

  def initials
    email[0]
  end
end
