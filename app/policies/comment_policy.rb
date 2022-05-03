# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def create?
    user && user.permission?('writer') || user.permission?('activityWriter')
  end
end
