# RailsSettings Model
class Setting < RailsSettings::Base
  STYLES = [
    :marketplace_weaker_style_size, :marketplace_weaker_style_weight,
    :marketplace_weaker_style_face, :marketplace_weaker_style_color,
    :marketplace_weak_style_size, :marketplace_weak_style_weight,
    :marketplace_weak_style_face, :marketplace_weak_style_color,
    :marketplace_basic_style_size, :marketplace_basic_style_weight,
    :marketplace_basic_style_face, :marketplace_basic_style_color,
    :marketplace_strong_style_size, :marketplace_strong_style_weight,
    :marketplace_strong_style_face, :marketplace_strong_style_color,
    :marketplace_stronger_style_size, :marketplace_stronger_style_weight,
    :marketplace_stronger_style_face, :marketplace_stronger_style_color,
    :marketplace_strongest_style_size, :marketplace_strongest_style_weight,
    :marketplace_strongest_style_face, :marketplace_strongest_style_color,
    :marketplace_face, :marketplace_background_color, :marketplace_weight
  ]

  cache_prefix { "v1" }

  field :marketplace_weaker_style_size, type: :string
  field :marketplace_weaker_style_weight, type: :string
  field :marketplace_weaker_style_face, type: :string
  field :marketplace_weaker_style_color, type: :string

  field :marketplace_weak_style_size, type: :string
  field :marketplace_weak_style_weight, type: :string
  field :marketplace_weak_style_face, type: :string
  field :marketplace_weak_style_color, type: :string

  field :marketplace_basic_style_size, type: :string
  field :marketplace_basic_style_weight, type: :string
  field :marketplace_basic_style_face, type: :string
  field :marketplace_basic_style_color, type: :string

  field :marketplace_face, type: :string
  field :marketplace_weight, type: :string
  field :marketplace_background_color, type: :string

  field :marketplace_strong_style_size, type: :string
  field :marketplace_strong_style_weight, type: :string
  field :marketplace_strong_style_face, type: :string
  field :marketplace_strong_style_color, type: :string

  field :marketplace_stronger_style_size, type: :string
  field :marketplace_stronger_style_weight, type: :string
  field :marketplace_stronger_style_face, type: :string
  field :marketplace_stronger_style_color, type: :string

  field :marketplace_strongest_style_size, type: :string
  field :marketplace_strongest_style_weight, type: :string
  field :marketplace_strongest_style_face, type: :string
  field :marketplace_strongest_style_color, type: :string

  field :backend_basic_style_color, type: :string
  field :backend_strong_style_color, type: :string
end
