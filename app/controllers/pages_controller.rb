# frozen_string_literal: true

# E.g /terms /privacy pages
class PagesController < ApplicationController
  before_action :set_ivars
  after_action :verify_authorized

  def landing
    authorize nil, policy_class: PagePolicy

    raise unless apollo_root_request? # this shouldn't happen

    redirect_to @zrea.root
  end

  private

  def set_ivars
    @zrea = if request.host.ends_with?(APOLLO_BACKEND_DOM)
              Zrea::Backend.new
            elsif request.host.ends_with?(APOLLO_MARKETPLACE_DOM)
              Zrea::Marketplace.new
            elsif request.host.ends_with?(APOLLO_MBO_DOM)
              Zrea::Mbo.new
            end
  end
end
