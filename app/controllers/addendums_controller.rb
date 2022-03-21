# frozen_string_literal: true

# :nodoc:
class AddendumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_addendum
  before_action :set_area

  def show
    authorize @addendum
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_addendum
    @addendum = Addendum.find(params[:id])
  end

  def set_area
    @area = Area::Backend.new
  end
end
