# frozen_string_literal: true

# :nodoc:
class AddendumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_addendum
  before_action :set_area_backend
  after_action :verify_authorized

  def show
    authorize @addendum
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_addendum
    @addendum = Addendum.find(params[:id])
  end
end
