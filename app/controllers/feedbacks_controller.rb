# frozen_string_literal: true

# Feedbacks Controller
class FeedbacksController < ApplicationController
  before_action :set_record, only: %i[show new create]
  before_action :set_area_offer
  before_action :authorize_feedback_policy
  after_action :verify_authorized

  def show; end

  def new; end

  def create
    if @mbo_request.second_seller_mode?
      @record.update(second_seller_rejected_feedback: rejected_feedback)
    else
      @record.update(rejected_feedback: rejected_feedback)
    end
    respond_to do |format|
      format.turbo_stream do
        redirect_to request.referrer.gsub(%r{/new\z}, ''), notice: 'Feedback submitted'
      end
    end
  end

  private

  def authorize_feedback_policy
    authorize nil, policy_class: FeedbackPolicy
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_record
    @mbo_request = MboRequest.new(token: params[:token])
    @record = @mbo_request.record
  end

  def rejected_feedback
    params[:rejected_feedback]
  end
end
