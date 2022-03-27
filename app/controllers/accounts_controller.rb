# frozen_string_literal: true

# Accounts Controller
class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: %i[show edit update destroy]
  before_action :set_ivars
  before_action :authorize_account

  # GET /accounts/1 or /accounts/1.json
  def show; end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    @message = 'Saved'
    @account.update(password: params[:password]) if savable?
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: @message }),
          turbo_stream.replace('accounts-show-panel', partial: '/accounts/show/main', locals: { user: @account })
        ]
      end
    end
  end

  private

  def authorize_account
    authorize @account, policy_class: AccountPolicy
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = User.find(params[:id])
  end

  def valid?
    params[:password] == params[:password_confirmation]
  end

  def savable?
    result = params[:password].present? && valid?
    @message = 'Error' unless result
    result
  end

  def set_ivars
    @area = Area::Backend.new
  end
end
