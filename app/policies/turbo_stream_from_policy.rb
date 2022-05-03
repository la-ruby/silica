# frozen_string_literal: true

class TurboStreamFromPolicy < ApplicationPolicy
  def backend_regular_user_toast_stream?
    user && (user.permission?('reader') || user.permission?('activityReader'))
  end

  def backend_regular_user_activity_n_stream?
    user && (user.permission?('reader') || user.permission?('activityReader'))
  end
end
