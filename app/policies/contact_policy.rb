# frozen_string_literal: true

class ContactPolicy < ApplicationPolicy
  def index?
    user && user.permission?('reader') || user.permission?('contactsReader')
  end

  def create?
    user && user.permission?('writer') || user.permission?('contactsWriter')
  end

  def refresh?
    user && user.permission?('reader') || user.permission?('contactsReader')
  end
end
