# frozen_string_literal: true

# E.g /terms /privacy pages
class PagesController < ApplicationController
  before_action :set_ivars

  def landing
    raise unless apollo_root_request? # this shouldn't happen

    redirect_to @area.root
  end

  private

  def set_ivars
    @area = if request.host.ends_with?(APOLLO_BACKEND_DOM)
              Area::Backend.new
            elsif request.host.ends_with?(APOLLO_MARKETPLACE_DOM)
              Area::Marketplace.new
            elsif request.host.ends_with?(APOLLO_MBO_DOM)
              Area::Mbo.new
            end
  end
end
