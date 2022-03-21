class InquiriesController < ApplicationController
  before_action :set_inquiry, only: %i[ show edit update destroy ]

  # POST /inquiries or /inquiries.json
  def create
    @inquiry = Inquiry.new(inquiry_params)
    message = (@inquiry.valid? ? "Thank you! We'll be in touch." : 'Please fill out the form')
    NotificationsMailer.inquiry(@inquiry).deliver_now

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: message }),
          # turbo_stream.replace(helpers.dom_id(@listing, :heart), partial: '/heart', locals: { listing_id: @listing.id })
        ]
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inquiry
    end

    # Only allow a list of trusted parameters through.
    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :phone, :url, :ip)
    end
end
