# frozen_string_literal: true

# Contact Search Policy
class ContactSearchPolicy < ApplicationPolicy
  def create?
    user && !user.limited?
  end
end
