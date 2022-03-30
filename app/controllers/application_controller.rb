# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include Pundit::Authorization

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
end
