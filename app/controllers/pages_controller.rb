# frozen_string_literal: true

# E.g /terms /privacy pages
class PagesController < ApplicationController
  before_action :set_area_generic
  after_action :verify_authorized

  def landing
    authorize nil, policy_class: PagePolicy

    raise unless silica_root_request? # this shouldn't happen

    redirect_to silica_root
  end

  private

  def silica_root
    if request.host.ends_with?(APOLLO_BACKEND_DOM)
      Area::Backend.root
    elsif request.host.ends_with?(APOLLO_MARKETPLACE_DOM)
      Area::Market.root
    elsif request.host.ends_with?(APOLLO_MBO_DOM)
      Area::Offer.root
    end
  end
end
