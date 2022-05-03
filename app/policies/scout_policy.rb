# frozen_string_literal: true

class ScoutPolicy < ApplicationPolicy
  def create?
    user && user.permission?('writer') || user.permission?('inspectionWriter')
  end
end
