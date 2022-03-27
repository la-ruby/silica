# frozen_string_literal: true

# Contact Policy
class ContactPolicy < ApplicationPolicy
  def index?
    user && !user.limited?
  end

  def create?
    user && !user.limited?
  end

  def refresh?
    user && !user.limited?
  end
end
