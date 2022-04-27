# frozen_string_literal: true

class TurboStreamFromPolicy < ApplicationPolicy
  def backend_regular_user_toast_stream?
    user && user.has_trait?(:backend_regular_user)
  end

  def backend_regular_user_activity_n_stream?
    user && user.has_trait?(:backend_regular_user)
  end
end
