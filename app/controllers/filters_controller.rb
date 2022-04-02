# frozen_string_literal: true

# FiltersController
class FiltersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area_backend
  after_action :verify_authorized

  def create
    authorize nil, policy_class: FilterPolicy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('projects-index-table-wrapper', partial: '/projects/index/table_wrapper',
                                                               locals: split_up_locals(params))
        ]
      end
    end
  end

  private

  def project_search(params)
    Project.search(query: params[:query],
                   statefilter: params[:statefilter], cityfilter: params[:cityfilter],
                   req_date: params[:req_date], offer_sent: params[:offer_sent],
                   sourcefilter: params[:sourcefilter], statusfilter: params[:statusfilter],
                   sort_by: params[:sort_by], sort_direction: params[:sort_direction], page: params[:page])
  end

  def split_up_locals(params)
    { projects: project_search(params),
      statefilter: params[:statefilter], cityfilter: params[:cityfilter],
      req_date: params[:req_date], offer_sent: params[:offer_sent],
      sourcefilter: params[:sourcefilter], statusfilter: params[:statusfilter],
      sort_by: params[:sort_by], sort_direction: params[:sort_direction], page: params[:page] }
  end
end
