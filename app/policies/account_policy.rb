# frozen_string_literal: true

# Account Policy
class AccountPolicy < ApplicationPolicy
  def show?
    user.id == record.id
  end

  def update?
    user.id == record.id
  end
end
