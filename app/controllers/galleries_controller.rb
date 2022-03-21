# frozen_string_literal: true

class GalleriesController < ApplicationController
  # POST
  def create
    url = request.env['HTTP_REFERER']
    url += '?gallery=1' unless url =~ /gallery=\d+/
    respond_to do |format|
      format.turbo_stream { redirect_to url }
    end
  end
end
