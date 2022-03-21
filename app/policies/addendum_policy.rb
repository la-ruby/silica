# frozen_string_literal: true

class AddendumPolicy < ApplicationPolicy
  def show?
    user&.staff?
  end
end
