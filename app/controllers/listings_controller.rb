# frozen_string_literal: true

class ListingsController < ApplicationController
  before_action :set_zrea
  before_action :set_listing, only: [:show]
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

  def set_zrea
    @zrea = Zrea::Marketplace.new
  end
end
