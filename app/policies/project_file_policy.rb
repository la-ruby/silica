# frozen_string_literal: true

class ProjectFilePolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    true
  end
end
