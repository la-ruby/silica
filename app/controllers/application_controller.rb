# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include Pundit::Authorization

  after_action :silica_trace # TODO: remove me

  def silica_trace
    "\n#{controller_name}##{action_name}_#{view_context.current_area}"
  end

  # /devise/wiki/How-To:-Change-the-redirect-path-after-destroying-a-session-i.e.-signing-out
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(_)
    '/users/sign_in'
  end

  def apollo_root_request?
    request.fullpath == '/'
  end

  def set_zrea_backend
    @zrea = Zrea::Backend.new    
  end

  def set_area_backend
    @area = Area::Backend.new
  end

  def set_area_offer
    @area = Area::Offer.new
  end

  def set_area_market
    @area = Area::Market.new
  end

  def set_area_generic
    @area = Area::Generic.new
  end

  def set_area_landing
    @area = Area::Landing.new
  end
end
