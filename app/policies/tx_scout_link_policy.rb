# frozen_string_literal: true

class TxScoutLinkPolicy < ApplicationPolicy
  def create?
    user && !user.limited?
  end
end
