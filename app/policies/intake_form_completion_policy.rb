# frozen_string_literal: true

class IntakeFormCompletionPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    true
  end
end
