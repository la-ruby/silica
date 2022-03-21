# frozen_string_literal: true

class FiltersController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_example, only: %i[ show edit update destroy ]

  # POST /examples or /examples.json
  def create
    authorize nil, policy_class: FilterPolicy
    # @example = Example.new(example_params)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('projects-index-table-wrapper', partial: '/projects/index/table_wrapper', locals: { projects: Project.search(query: params[:query], statefilter: params[:statefilter], cityfilter: params[:cityfilter], req_date: params[:req_date], offer_sent: params[:offer_sent], sourcefilter: params[:sourcefilter], page: params[:page]), query: params[:query], statefilter: params[:statefilter], cityfilter: params[:cityfilter], req_date: params[:req_date], offer_sent: params[:offer_sent], sourcefilter: params[:sourcefilter], page: params[:page] })
        ]
      end
    end
  end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_example
  #     @example = Example.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def example_params
  #     params.require(:example).permit(:title, :body, :seed)
  #   end
end
