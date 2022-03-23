# frozen_string_literal: true

class SendgridMarketingListPolicy < ApplicationPolicy
  def index?
    user && !user.limited?
  end
end
