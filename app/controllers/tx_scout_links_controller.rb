# Send out scout link
class TxScoutLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area_backend # to silence warning
  after_action :verify_authorized

  def create
    authorize nil, policy_class: TxScoutLinkPolicy
    project = Project.find(tx_scout_link_params[:project_id])
    NotificationsMailer.tx_scout_link(project).deliver_now
    ScoutMail.new.perform(project)
    project.update(scout_sent_at: Time.now.iso8601)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: "Emailed #{project.email}" }),
          turbo_stream.replace('apollo-inspection-overview-pane', partial: '/scouts/inspection_overview_pane', locals: { project_id: project.id })
        ]
      end
    end

  end

  private
    # Only allow a list of trusted parameters through.
    def tx_scout_link_params
      params.require(:tx_scout_link).permit(:project_id)
    end
end
