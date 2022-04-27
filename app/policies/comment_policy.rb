# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def create?
    user # && !user.limited?
  end
end
