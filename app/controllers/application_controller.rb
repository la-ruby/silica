# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # after_action :silica_trace
  # def silica_trace
  #   puts "TRACING #{@area} #{controller_name unless @area}"
  # end

  # /devise/wiki/How-To:-Change-the-redirect-path-after-destroying-a-session-i.e.-signing-out
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(_)
    '/users/sign_in'
  end

  def apollo_root_request?
    request.fullpath == '/'
  end

  def set_area_backend
    @area = Area::Backend.new    
  end
end
