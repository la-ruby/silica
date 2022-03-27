# frozen_string_literal: true

# Addendum Version Policy
class AddendumVersionPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    true
  end
end
