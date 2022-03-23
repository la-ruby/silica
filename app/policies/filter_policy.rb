# frozen_string_literal: true

# The FilterPolicy
class FilterPolicy < ApplicationPolicy
  def create?
    true
  end
end
