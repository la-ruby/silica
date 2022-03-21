# frozen_string_literal: true

class AddendumVersionPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    true
  end
end
