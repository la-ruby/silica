class Event < ApplicationRecord
  # Definitions
  DEFINITIONS = [
    { 'name' => 'project_creation', 'toast' => '1', 'toast_stength': '100', 'animation': '1', 'animation_strength': '100', 'animation_phase_in_timesan': nil, 'animation_phase_in_start': nil, 'voice': 'en_US', 'voice_strength': '100', 'voice_phase_in_timesan': nil, 'voice_phase_in_start': nil }
  ]

  # blog.corsego.com/turbo-hotwire-broadcasts
  after_create_commit do
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
