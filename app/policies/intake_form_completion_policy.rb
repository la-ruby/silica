# frozen_string_literal: true

# Intake Form Completion Policy
class IntakeFormCompletionPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    true
  end
end
