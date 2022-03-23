# frozen_string_literal: true

# This class check if StatusPolicy is less than ApplicationPolicy
class StatusPolicy < ApplicationPolicy
  def update?
    true
  end
end
