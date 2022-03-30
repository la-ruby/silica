class SearchesController < ApplicationController
  before_action :set_area_market
  after_action :verify_authorized

  # POST /searches or /searches.json
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
end
