# frozen_string_literal: true

# The AddendumPolicy
class AddendumPolicy < ApplicationPolicy
  def show?
    user&.staff?
  end
end
