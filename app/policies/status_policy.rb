# frozen_string_literal: true

class StatusPolicy < ApplicationPolicy
  def update?
    true
  end
end
