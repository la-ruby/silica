# frozen_string_literal: true

class TxScoutLinkPolicy < ApplicationPolicy
  def create?
    user && user.permission?('writer') || user.permission?('inspectionWriter')
  end
end
