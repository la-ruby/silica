# frozen_string_literal: true

class ContactSearchPolicy < ApplicationPolicy
  def create?
    user && !user.limited?
  end
end
