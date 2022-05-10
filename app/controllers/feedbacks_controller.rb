# frozen_string_literal: true

class FeedbacksController < ApplicationController
  before_action :set_record, only: %i[show new create]
  before_action :set_area_offer
  after_action :verify_authorized

  # GET /examples/1 or /examples/1.json
  def show
    authorize nil, policy_class: FeedbackPolicy
  end

  # GET /examples/new
  def new
    authorize nil, policy_class: FeedbackPolicy
  end

  # POST /examples or /examples.json
  def create
    authorize nil, policy_class: FeedbackPolicy

    @mbo_request.second_seller_mode? ? @record.update(second_seller_rejected_feedback: rejected_feedback) : @record.update(rejected_feedback: rejected_feedback)

    Event.create(
      category: (@record.is_a?(Repc) ? 'repc_feedback': 'addendum_feedback'),
      timestamp: Time.now,
      record_id: @mbo_request.project.id,
      record_type: 'Project',
      inventor_id: current_user.id
    )

    respond_to do |format|
      format.turbo_stream do
        redirect_to request.referrer.gsub(%r{/new\z}, ''), notice: 'Feedback submitted'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_record
    # @example = Example.find(params[:id])
    @mbo_request = MboRequest.new(token: params[:token])
    @record = @mbo_request.record
  end

  def rejected_feedback
    params[:rejected_feedback]
  end
end
