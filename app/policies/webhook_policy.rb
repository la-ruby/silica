# frozen_string_literal: true

class WebhookPolicy < ApplicationPolicy
  def webhook?
    true
  end

  def webhook_signed_by_company?
    true
  end

  def webhook_revert?
    true
  end

  def webhook_sendgrid_event?
    true
  end
end
