# frozen_string_literal: true

# The AddendumVersionPolicy
class AddendumVersionPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    true
  end
end
