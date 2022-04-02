# frozen_string_literal: true

# Listings controller
class ListingsController < ApplicationController
  before_action :set_listing, only: [:show]
  before_action :set_area_market
  after_action :verify_authorized

  def index
    authorize Listing
  end

  def show
    authorize @listing
  end

  def bid; end

  private

  def set_listing
    @listing = Listing.find params[:id]
  end
end
