# frozen_string_literal: true

# Allows changing colors
class ConfigurationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area_backend
  before_action :authorize_configuration_policy
  after_action :verify_authorized

  def edit; end

  def update
    Setting::STYLES.each do |item|
      Setting.send(:"#{item}=", params[item]) if params.key?(item)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: 'Saved' })
        ]
      end
    end
  end

  private

  def authorize_configuration_policy
    authorize nil, policy_class: ConfigurationPolicy
  end
end
