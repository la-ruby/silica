class ContactsController < ApplicationController
  before_action :set_area

  # GET /examples or /examples.json

  def index
    authorize nil, policy_class: ContactPolicy
    set_index_ivars
    # @examples = Example.all
  end

  def create
    authorize nil, policy_class: ContactPolicy
    $recent_contacts ||= []
    $recent_contacts << [
      contact_params[:first_name].presence ||  Faker::Name::first_name,
      contact_params[:last_name].presence || Faker::Name::last_name,
      contact_params[:phone].presence || Faker::PhoneNumber.cell_phone,
      contact_params[:email].presence || Faker::Internet.email,
      ['UT', 'NC'].sample(rand(1..2)).join(', '),
      '05/11'
    ]

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: 'Saved' }),
          turbo_stream.replace('sendgrid-marketing-lists-index-bar', partial: '/contacts/index/bar', locals: {  }),
          turbo_stream.replace('contacts-index-table', partial: '/contacts/index/table', locals: {  }),
        ]
      end
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :phone, :email)
    end

    def set_area
      @area = Area::Backend.new
    end

    def set_index_ivars
      Rails.cache.write("contact_count_at_sendgrid", -1) unless Rails.cache.read("contact_count_at_sendgrid")
      @fresh = true
      @fresh = false if Contact.count != Rails.cache.read("contact_count_at_sendgrid")
    end
end
