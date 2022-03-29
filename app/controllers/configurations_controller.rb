# frozen_string_literal: true

# Allows changing colors
class ConfigurationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area_backend

  def edit
    authorize nil, policy_class: ConfigurationPolicy
  end

  def update
    authorize nil, policy_class: ConfigurationPolicy
    Setting::STYLES.each { |item| Setting.send(:"#{item}=", params[item]) }

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: 'Saved' })
        ]
      end
    end
  end
end
