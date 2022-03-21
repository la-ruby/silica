# frozen_string_literal: true

# aka My Offer Portal
class MyoffersController < ApplicationController
  before_action :set_ivars
  before_action :set_area

  def crayon
    mark_as_accepted if params[:event] == 'signing_complete'
    render template: '/component/_crayon',
           layout: 'application',
           locals:
             {

               second_seller_mode: @mbo_request.second_seller_mode?,
               repc_id: @record.id
             }
  end

  private

  def set_mbo_request
    @mbo_request = MboRequest.new(token: params[:token])
    @record = @mbo_request.record
    @timestamp = Time.now.iso8601
  end

  def mark_as_accepted
    if @mbo_request.second_seller_mode?
      @record.update(second_seller_accepted_at: @timestamp)
    else
      @record.update(accepted_at: @timestamp)
    end
    @mbo_request.project.update(accepted_at: @timestamp) if @record.accepted?
  end

  def set_ivars
    set_mbo_request
  end

  def set_area
    @area = Area::Mbo.new
  end
end
