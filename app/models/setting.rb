# RailsSettings Model
class Setting < RailsSettings::Base
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

end
