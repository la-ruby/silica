# frozen_string_literal: true

# Status Policy
class StatusPolicy < ApplicationPolicy
  def update?
    true
  end
end
