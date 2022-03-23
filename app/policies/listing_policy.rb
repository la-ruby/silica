# frozen_string_literal: true

# The ListingPolicy
class ListingPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.listed == 'true'
  end
end
