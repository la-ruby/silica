# frozen_string_literal: true

# The IntakeFormCompletionPolicy
class IntakeFormCompletionPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    true
  end
end
