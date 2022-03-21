# frozen_string_literal: true

# A revert is a re-sync of database
class RevertsController < ApplicationController
  # POST
  def create
    echo = (APOLLO_INTERNAL_PRODUCTION ? ' ' : 'echo ')
    Rails.logger.info `#{echo}curl 'https://#{APOLLO_BACKEND_DOM}/webhook_revert'`
    sleep 5
    flash[:notice] = 'Requested re-sync. This can take up to a minute depending on the number of projects and images'
    respond_to do |format|
      format.turbo_stream { redirect_to request.env['HTTP_REFERER'].presence || '/' }
    end
  end
end
