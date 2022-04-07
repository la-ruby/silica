class AddendumVersionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_addendum_version, only: %i[update]
  before_action :set_area_backend
  after_action :verify_authorized

  def update
    authorize @addendum_version
    streams = saves
    streams = send_addendum_version_to_seller if params[:what_was_clicked] == 'send_addendum_version_to_seller'
    streams = sign_addendum_version if params[:what_was_clicked] == 'sign_addendum_version'
    streams = discard_addendum_version if params[:what_was_clicked] == 'discard_addendum_version'

    respond_to do |format|
       format.turbo_stream do
         render turbo_stream: streams
       end
    end
  end

  # POST /addendum_versions or /addendum_versions.json
  def create
    authorize nil, policy_class: AddendumVersionPolicy
    project = Project.find(params[:project_id])
    Addendum.add_an_addendum(project)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: 'Added' }),
          turbo_stream.replace('apollo-underwriting-review-offer-pane', partial: '/projects/underwriting_review_offer/underwriting_review_offer_pane', locals: { project_id: project.id })
        ]
      end
    end
  end

  private

    def set_addendum_version
      @addendum_version = AddendumVersion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def addendum_version_params
      params.require(:addendum_version).permit(:expiration, :deadline, :terms) if  params[:addendum_version].present?
    end

    def saves
      if params[:addendum_version].present?
        @addendum_version.update(terms: addendum_version_params[:terms])
        @addendum_version.update(expiration: (DateTime.strptime(addendum_version_params[:expiration],'%Y-%m-%dT%R').iso8601 rescue nil))
        @addendum_version.update(deadline: (DateTime.strptime(addendum_version_params[:deadline],'%Y-%m-%dT%R').iso8601 rescue nil))
      end
      [ turbo_stream.replace('flashes', partial: '/flashes', locals: { message: 'Saved' }),
        turbo_stream.replace("addendum-#{@addendum_version.addendum.id}-addendum-version-#{@addendum_version.id}-panel", partial: '/addendum_versions/show', locals: { addendum_version_id: @addendum_version.id, editable: true  })
      ]

    end

    def send_addendum_version_to_seller
      sendgrid_message_id = AddendumMail.new.perform(
        to: @addendum_version.addendum.project.email,
        mop_token: @addendum_version.addendum.project.repc.mop_token,
        name: @addendum_version.addendum.project.name,
        street: @addendum_version.addendum.project.street
      )
      if @addendum_version.addendum.project.dual?
        AddendumMail.new.perform(
          to: @addendum_version.addendum.project.secondEmail,
          mop_token: @addendum_version.addendum.project.repc.second_seller_mop_token,
          name: @addendum_version.addendum.project.secondName,
          street: @addendum_version.addendum.project.street
        )
      end
      @addendum_version.addendum.project.update(sendgrid_message_id: sendgrid_message_id)
      @addendum_version.update(sent_to_seller_at: Time.now.iso8601)
      [
        turbo_stream.replace('flashes', partial: '/flashes', locals: { message: 'Sent!' }),
        turbo_stream.replace("addendum-#{@addendum_version.addendum.id}-addendum-version-#{@addendum_version.id}-panel", partial: '/addendum_versions/show', locals: { addendum_version_id: @addendum_version.id, editable: true  }),
      ]
    end

    def sign_addendum_version
      [
        turbo_stream.replace('apollo-redirect', partial: '/redirect', locals: { url: @addendum_version.addendum.project.create_docusign_envelope_for_addendum_version(@addendum_version.id) })
      ]
    end

    def discard_addendum_version
      new_addendum_version = @addendum_version.addendum.add_an_addendum_version
      [
        turbo_stream.replace('apollo-underwriting-review-offer-pane', partial: '/projects/underwriting_review_offer/underwriting_review_offer_pane', locals: { project_id: @addendum_version.addendum.project.id }),
        turbo_stream.replace('flashes', partial: '/flashes', locals: { message: "Added draft #{new_addendum_version.version}" })
      ]
    end
end
