# frozen_string_literal: true

# Allows chaging colors
class ConfigurationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area

  def edit
    authorize nil, policy_class: ConfigurationPolicy
  end

  def update
    authorize nil, policy_class: ConfigurationPolicy
    [ 'marketplace_weaker_style_size', 'marketplace_weaker_style_weight',
      'marketplace_weaker_style_face', 'marketplace_weaker_style_color',
      'marketplace_weak_style_size', 'marketplace_weak_style_weight',
      'marketplace_weak_style_face', 'marketplace_weak_style_color',
      'marketplace_basic_style_size', 'marketplace_basic_style_weight',
      'marketplace_basic_style_face', 'marketplace_basic_style_color',
      'marketplace_strong_style_size', 'marketplace_strong_style_weight',
      'marketplace_strong_style_face', 'marketplace_strong_style_color',
      'marketplace_stronger_style_size', 'marketplace_stronger_style_weight',
      'marketplace_stronger_style_face', 'marketplace_stronger_style_color',
      'marketplace_strongest_style_size', 'marketplace_strongest_style_weight',
      'marketplace_strongest_style_face', 'marketplace_strongest_style_color',
      'marketplace_face', 'marketplace_background_color', 'marketplace_weight',
    ].each do |item|
      Setting.send(:"#{item}=", params[item])
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

  def set_area
    @area = Area::Backend.new
  end
end
