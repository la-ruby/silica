# frozen_string_literal: true

class RevertPolicy < ApplicationPolicy
  def create?
    true
  end
end
