# frozen_string_literal: true

class ScoutPolicy < ApplicationPolicy
  def create?
    user && !user.limited?
  end
end
