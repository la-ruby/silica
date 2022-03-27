# frozen_string_literal: true

# Filter Policy
class FilterPolicy < ApplicationPolicy
  def create?
    true
  end
end
