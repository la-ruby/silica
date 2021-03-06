# frozen_string_literal: true

class ListingPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.listed == 'true'
  end
end
