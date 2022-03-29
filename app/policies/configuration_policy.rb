# frozen_string_literal: true

class ConfigurationPolicy < ApplicationPolicy
  def edit?
    user&.staff?
  end

  def update?
    user&.staff?
  end
end
