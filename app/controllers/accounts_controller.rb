class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: %i[ show edit update destroy ]
  before_action :set_ivars

  # GET /accounts/1 or /accounts/1.json
  def show
    authorize @account, policy_class: AccountPolicy
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    authorize @account, policy_class: AccountPolicy
    @message = "Saved"
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
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = User.find(params[:id])
    end

    def valid?
      params[:password] == params[:password_confirmation]
    end

    def savable?
      result = params[:password].present? && valid?
      @message = "Error" unless result
      result
    end

    def set_ivars
      @zrea = Zrea::Backend.new
    end
end
