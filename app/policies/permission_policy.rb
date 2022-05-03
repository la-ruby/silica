# frozen_string_literal: true

class PermissionPolicy < ApplicationPolicy
  def show?
    user && user.permission?('reader')
  end

  def update?
    user && user.permission?('writer')
  end
end
