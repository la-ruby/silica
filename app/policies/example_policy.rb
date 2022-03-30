# frozen_string_literal: true

class ExamplePolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  def index?
    true
  end

  def new?
    true
  end

  def edit?
    true
  end
end
