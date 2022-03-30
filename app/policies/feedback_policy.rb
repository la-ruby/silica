# frozen_string_literal: true

# Weird name
class FeedbackPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end
end
