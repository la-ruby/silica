# frozen_string_literal: true

# Project is the "mother" of most models
class ProjectsController < ApplicationController
  before_action :set_nav

  before_action :authenticate_user!
  before_action :set_project, except: %i[new create index]

  def index
    @projects = Project.search(page: params[:page])
    @page = params[:page]
    @query = params[:query]
    @statefilter = params[:statefilter]
    @cityfilter = params[:cityfilter]
    @sourcefilter = params[:sourcefilter]
    @req_date = params[:req_date]
    @offer_sent = params[:offer_sent]
    @sort_by = params[:sort_by]
    @sort_direction = params[:sort_direction]
    authorize @projects
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # POST /projects
  def create
    respond_to do |format|
      format.html do
        if create_project
          redirect_to "/projects/#{@project.id}/overview"
        else
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    @project.update(project_params)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: 'Saved' }),
          turbo_stream.replace('lenders', partial: '/lenders', locals: { project_id: @project.id })
        ]
      end
    end
  end

  private

  def create_project
    @project = Project.new({ **project_params, 'status' => 'Open', 'req_date' => Time.now,
                                               'direction' => 'Outbound' })
    result = @project.save
    flash[:notice] = (result ? 'Created.' : @project.errors.full_messages.join(', '))
    result
  end

  # Only allow a list of trusted parameters through.
  # rubocop:disable Naming/VariableNumber
  def project_params
    params.require(:project).permit(:direction, :owner_name, :owner_email, :owner_phone, :owner2_name, :owner2_email,
                                    :owner2_phone, :timeline, :street, :street2, :city, :state, :zip, :req_date,
                                    :offer_sent, :offer_view, :offer_accepted, :addendum_sent, :source, :tags,
                                    :status, :name, :email, :phone, :expectedtimeline, :secondName,
                                    :secondPhone, :secondEmail,
                                    :lender_1, :lender_2,
                                    :beds, :baths, :sqft, :plot, :year, :property_type, :price_sqft, :hoa_fees,
                                    :heating, :cooling, :lot_size, :owner_occupied, :sales_notes_for_underwriting,
                                    :underwriting_notes_for_sales, :assignment_fee)
  end
  # rubocop:enable Naming/VariableNumber

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  def set_nav
    @menu_mode = 'backend'
  end
end
