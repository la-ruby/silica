# frozen_string_literal: true

class ContactPolicy < ApplicationPolicy
  def index?
    user && !user.limited?
  end

  def create?
    user && !user.limited?
  end
end
