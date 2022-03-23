# frozen_string_literal: true

# The BlastPolicy class
class BlastPolicy < ApplicationPolicy
  def create?
    true
  end
end
