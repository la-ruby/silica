class Event < ApplicationRecord
  TOASTABLE_CATEGORIES = [
    'project_creation',
    'addition_repc_signed_by_company_at',
    'project_comment'

  ]
  ACTIVITYBLE_CATEGORIES = [
    'project_creation',
    'addition_repc_signed_by_company_at',
    'project_comment'
  ]
  

  # blog.corsego.com/turbo-hotwire-broadcasts
  after_create_commit do
    if TOASTABLE_CATEGORIES.include?(category)
      broadcast_prepend_to('backend_regular_user_toast_stream', target: 'silica-toasts', partial: "events/toast", locals: { event: self })
    end
    if ACTIVITYBLE_CATEGORIES.include?(category)
      broadcast_prepend_to("backend_regular_user_activity_#{record.id}_stream", target: "activity_#{record.id}", partial: "events/activity", locals: { event: self })
    end
  end

  def record
    record_type.constantize.find(record_id)
  end

  def inventor
    User.find(inventor_id)
  rescue ActiveRecord::RecordNotFound
    if inventor_id == -2
      CompanyUser.new
    # else
    #   NullUser.new
    end
  end
end
