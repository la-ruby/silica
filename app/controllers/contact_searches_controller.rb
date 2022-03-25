class ContactSearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact_search, only: %i[ show edit update destroy ]

  # POST /examples or /examples.json
  def create
    authorize nil, policy_class: ContactSearchPolicy
    ransack = Contact.ransack(
      email_or_first_name_or_last_name_or_phone_mobile_or_phone_work_or_investing_location_or_sendgrid_created_at_cont:
        contact_search_params[:query])
    ransack.sorts = "#{contact_search_params[:sort]} #{contact_search_params[:direction]}"

    contacts_table_state = ContactsTableState.new(
      query: contact_search_params[:query],
      records: ransack,
      sort: contact_search_params[:sort],
      page: contact_search_params[:page],
      direction: contact_search_params[:direction])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('contacts-index-table', partial: '/contacts/index/table', locals: { contacts_table_state: contacts_table_state })
        ]
      end
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def contact_search_params
      params.require(:contact_search).permit(:query, :sort, :direction, :page)
    end
end
