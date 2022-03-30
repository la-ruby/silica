# frozen_string_literal: true

class GalleriesController < ApplicationController
  after_action :verify_authorized

  # POST
  def create
    authorize nil, policy_class: GalleryPolicy

    url = request.env['HTTP_REFERER']
    url += '?gallery=1' unless url =~ /gallery=\d+/
    respond_to do |format|
      format.turbo_stream { redirect_to url }
    end
  end
end
