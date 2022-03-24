# frozen_string_literal: true

class RepcsController < ApplicationController
  before_action :authenticate_user!

  MONETARY_PARAMS = %w[balloon_payment estimated_remaining_mortgage monthly_payment down_payment
                       earnest_money closing_costs repair_costs service_fee company_offer_arv].freeze
  before_action :set_repc, only: %i[update] # %i[ show edit update destroy ]

  # PATCH/PUT /repcs/1 or /repcs/1.json
  def update
    authorize @repc
    streams = case params[:what_was_clicked]
              when 'save'
                save
              when 'sign_repc'
                save
                sign_repc
              when 'make_new_repc'
                save
                make_new_repc
              end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: streams
      end
    end
  end

  # # POST /repcs or /repcs.json
  # def create
  #   @repc = Repc.new(repc_params)

  #   respond_to do |format|
  #     if @repc.save
  #       format.html { redirect_to repc_url(@repc), notice: "Repc was successfully created." }
  #       format.json { render :show, status: :created, location: @repc }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @repc.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_repc
    @repc = Repc.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def repc_params
    params.require(:repc).permit(:agreement_date,
                                 :settlement_date,
                                 :inspection_period_deadline,
                                 :possession_date,
                                 :notes,
                                 :closing_costs_paid_by,
                                 :real_estate_professional,
                                 :offer_terms,
                                 :term_length,
                                 :interest_rate,
                                 :legal_description,
                                 :title_company,
                                 :service_fee_is_percentage,
                                 :balloon_payment,
                                 :estimated_remaining_mortgage,
                                 :monthly_payment,
                                 :down_payment,
                                 :earnest_money,
                                 :closing_costs,
                                 :repair_costs,
                                 :service_fee,
                                 :company_offer_arv)
  end

  def save
    sanitized_repc_params = repc_params.to_unsafe_hash.to_h do |k, v|
      v = v.gsub(/[^\d.]/, '') if MONETARY_PARAMS.include?(k)
      v = v.sub(/.00\z/, '') if MONETARY_PARAMS.include?(k) && v.ends_with?('.00')
      [k, v]
    end
    @repc.update(sanitized_repc_params)
    [
      turbo_stream.replace('prepare-repc-panel', partial: '/component/prepare_repc',
                                                 locals: { project_id: @repc.project_id }),
      turbo_stream.replace('flashes', partial: '/flashes', locals: { message: 'Saved' })
    ]
  end

  def sign_repc
    url = @repc.project.create_docusign_envelope(@repc.id)
    @repc.update(mutable: '0')
    [
      turbo_stream.replace('apollo-redirect', partial: '/redirect', locals: { url: url })
    ]
  end

  def make_new_repc
    old_repc = @repc
    new_repc = old_repc.dup
    new_repc.update(
      mutable: '1',
      rejected_feedback: nil,
      second_seller_rejected_feedback: nil,
      rejected_at: nil,
      second_seller_rejected_at: nil,
      accepted_at: nil,
      second_seller_accepted_at: nil,
      version: (old_repc.version.to_i + 1).to_s,
      mop_token: SecureRandom.hex,
      docusign_envelope_id: nil,
      signed_by_company_at: nil,
      sent_homeowner_at: nil,
      closing_costs: nil,
      repair_costs: nil,
      service_fee: nil,
      company_offer_arv: nil,
      legal_description: nil,
      title_company: nil
    )
    [
      turbo_stream.replace('prepare-repc-panel', partial: '/component/prepare_repc',
                                                 locals: { project_id: @repc.project_id })
    ]
  end
end
