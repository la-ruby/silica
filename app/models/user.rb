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
    email.split('@').first.gsub(/\W/, '_').titleize
  end

  # some restrictions apply to these users
  def limited?
    LIMITED_USERS.include?(email)
  end
end
