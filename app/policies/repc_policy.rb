# frozen_string_literal: true

class RepcPolicy < ApplicationPolicy
  def update?
    true
  end

  def show?
    true
  end
end
