# frozen_string_literal: true

class ListingsController < ApplicationController
  before_action :set_area
  before_action :set_listing, only: [:show]

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

  def set_area
    @area = Area::Marketplace.new
  end
end
