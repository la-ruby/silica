# frozen_string_literal: true

# Contact Searches Controller
class ContactSearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact_search, only: %i[show edit update destroy]
  before_action :set_area_backend
  after_action :verify_authorized

  # POST /examples or /examples.json
  def create
    authorize nil, policy_class: ContactSearchPolicy
    contacts_table = contacts_table_state(contact_search_params)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('contacts-index-table',
                               partial: '/contacts/index/table', locals: { contacts_table_state: contacts_table })
        ]
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def contact_search_params
    params.require(:contact_search).permit(:query, :sort, :direction, :page)
  end

  def contacts_table_state(params)
    ransack = Contact.ransack(
      email_or_first_name_or_last_name_or_phone_mobile_or_phone_work_or_investing_location_or_sendgrid_created_at_cont:
        contact_search_params[:query]
    )
    ransack.sorts = "#{contact_search_params[:sort]} #{contact_search_params[:direction]}"
    ContactsTableState.new(
      query: params[:query], records: ransack, sort: params[:sort],
      page: params[:page], direction: params[:direction]
    )
  end
end
