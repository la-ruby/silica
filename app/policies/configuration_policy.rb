# frozen_string_literal: true

class ConfigurationPolicy < ApplicationPolicy
  def show?
    user&.staff?
  end

  def update?
    user&.staff?
  end
end
