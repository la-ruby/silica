class ContactSearchesController < ApplicationController
  before_action :set_contact_search, only: %i[ show edit update destroy ]

  # POST /examples or /examples.json
  def create
    @contact_search = ContactSearch.new(contact_search_params.slice(:query))
    @contact_search.perform

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: "Testing" }),
          turbo_stream.replace('contacts-index-table', partial: '/contacts/index/table', locals: { contacts_table_state: ContactsTableState.new })
        ]
      end
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def contact_search_params
      params.require(:contact_search).permit(:query)
    end
end
