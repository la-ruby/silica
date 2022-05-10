class RepcDeliveriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area_backend
  after_action :verify_authorized

  # POST /examples or /examples.json
  def create
    authorize nil, policy_class: RepcDeliveryPolicy
    project = Project.find(params[:repc_delivery][:project_id])
    repc = Repc.find(params[:repc_delivery][:repc_id])
    repc.update(sent_homeowner_at: Time.now.iso8601)
    repc.project.update(offer_sent: Time.now.iso8601)
    repc.project.update(sendgrid_message_id:
      OfferMail.new.perform(to: repc.project.email, mop_token: repc.mop_token, name: repc.project.name)
    )
    if project.dual?
      repc.project.update(sendgrid_message_id:
        OfferMail.new.perform(to: repc.project.secondEmail, mop_token: repc.second_seller_mop_token, name: repc.project.secondName)
      )
    end
    Event.create(
      category: 'offer_sent',
      timestamp: Time.now,
      record_id: repc.project.id,
      record_type: 'Project',
      inventor_id: current_user.id
    )

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: 'Email Sent!' }),
        ]
      end
    end
  end
end
