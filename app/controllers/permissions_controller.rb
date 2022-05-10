# frozen_string_literal: true

class PermissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area_backend
  after_action :verify_authorized

  def show
    # used for testing notifications
    # Repc.last.update(accepted_at: nil)
    # sleep 1
    # Repc.last.update(accepted_at: Time.now.iso8601)

    authorize nil, policy_class: PermissionPolicy
  end

  def update
    authorize nil, policy_class: PermissionPolicy
    user = User.find(params[:user_id])
    old_permissions = user.permissions.join(', ')
    new_permissions = params[:permissions].reject(&:blank?).join(', ')
    user.update(permissions: params[:permissions].reject(&:blank?))
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: "Saved permissions: #{new_permissions} (old permissions: #{old_permissions})" })
        ]
      end
    end
  end
end
