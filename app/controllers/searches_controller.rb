# frozen_string_literal: true

class SearchesController < ApplicationController
  # before_action :authenticate_user!

  # POST /searches or /searches.json
  # rubocop: disable Metrics/AbcSize
  def create
    authorize nil, policy_class: SearchPolicy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('apollo-listings', partial: '/component/listings', locals: {
                                 q: params[:q],
                                 beds: params[:beds],
                                 baths: params[:baths],
                                 sort: params[:sort],
                                 page: params[:page],
                                 map: params[:map]
                               })
        ]
      end
    end
  end
  # rubocop: enable Metrics/AbcSize
end
