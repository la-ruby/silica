# frozen_string_literal: true

class ContactSearchPolicy < ApplicationPolicy
  def create?
    user && user.permission?('reader') || user.permission?('contactsReader')
  end
end
