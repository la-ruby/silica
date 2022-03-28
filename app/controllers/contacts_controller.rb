class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area

  # GET /examples or /examples.json

  def index
    authorize nil, policy_class: ContactPolicy
    set_index_ivars
    # @examples = Example.all
  end

  def create
    authorize nil, policy_class: ContactPolicy

    # to be moved elsewhere
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY2'])
    data = {
      list_ids: [ SENDGRID_MARKETING_LIST_ID ],
      contacts: [
        email: contact_params[:email],
        first_name: contact_params[:first_name],
        last_name: contact_params[:last_name],
        custom_fields: {
          e4_T: contact_params[:phone],
          w11_T: formatted_investing_location
        }
      ]
    }
    response = sg.client.marketing.contacts.put(request_body: data)
    tid = response.parsed_body.dig(:job_id)
    Rails.logger.info "Added #{tid}"

    15.times do |index|
      Rails.logger.info "Iteration #{index+1}"
      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY2'])
      response = sg.client.marketing.contacts.get
      break if response.parsed_body[:result]
        .select{|x| x[:email] == contact_params[:email] && x[:list_ids].include?(SENDGRID_MARKETING_LIST_ID) }.present?
      sleep 1 unless Rails.env.test?
    end

    CacheContactsJob.perform_later
    QuickCacheContactsJob.perform_later

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: "Added #{response.parsed_body.dig(:job_id)}" }),
          turbo_stream.replace('contacts-index-bar', partial: '/contacts/index/bar', locals: { contacts_bar_state: ContactsBarState.new }),
          turbo_stream.replace('contacts-index-table', partial: '/contacts/index/table', locals: { contacts_table_state: ContactsTableState.new(records: default_ransack) }),
        ]
      end
    end
  end

  def refresh
    authorize nil, policy_class: ContactPolicy
    CacheContactsJob.perform_now
    QuickCacheContactsJob.perform_now
    redirect_to "/contacts"
  end


  private
    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :phone, :email, :ut, :nc)
    end

    def set_area
      @area = Area::Backend.new
    end

    def set_index_ivars

      Rails.cache.write("contact_count_at_sendgrid", -1) unless Rails.cache.read("contact_count_at_sendgrid")
      @contacts_table_state = ContactsTableState.new(records: default_ransack)
      @contacts_bar_state = ContactsBarState.new
    end

    def default_ransack
      ransack = Contact.ransack
      ransack.sorts = "sendgrid_created_at desc"
      ransack
    end

    def formatted_investing_location
      arr = []
      arr << 'UT' if contact_params[:ut] == "1"
      arr << 'NC' if contact_params[:nc] == "1"
      str = arr.join('-')
      str = "-#{str}-" if str.present?
      str
    end
end
