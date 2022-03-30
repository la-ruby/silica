# frozen_string_literal: true

# A revert is a re-sync of database
class RevertsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area_backend
  after_action :verify_authorized

  # POST
  def create
    authorize nil, policy_class: RevertPolicy

    echo = (APOLLO_INTERNAL_PRODUCTION ? ' ' : 'echo ')
    Rails.logger.info `#{echo}curl 'https://#{APOLLO_BACKEND_DOM}/webhook_revert'`
    sleep 5 unless Rails.env.test?
    flash[:notice] = 'Requested re-sync. This can take up to a minute depending on the number of projects and images'
    respond_to do |format|
      format.turbo_stream { redirect_to request.env['HTTP_REFERER'].presence || '/' }
    end
  end
end
