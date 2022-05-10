# frozen_string_literal: true

class PermissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area_backend
  after_action :verify_authorized

  def show
    # TODO: remove me, used for testing notifications
    # Project.find(9).update(underwriting_notes_for_sales: nil)
    # sleep 1
    # Project.find(9).update(underwriting_notes_for_sales: "testing")

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
