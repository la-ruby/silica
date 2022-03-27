# frozen_string_literal: true

# Addendum Policy
class AddendumPolicy < ApplicationPolicy
  def show?
    user&.staff?
  end
end
