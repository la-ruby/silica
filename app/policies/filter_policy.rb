# frozen_string_literal: true

class FilterPolicy < ApplicationPolicy
  def create?
    true
  end
end
