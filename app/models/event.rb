class Event < ApplicationRecord
  # Definitions, activity here stands refers to the activity feed tab
  DEFINITIONS = [
    { 'category' => 'project_creation',                   'color' => 'primary', 'toast' => '1', 'toast_stength' => '100', 'activity' => '1', 'confetti' => '1', 'confetti_strength' => '100', 'confetti_phase_in_timesan' => nil, 'confetti_phase_in_start' => nil, 'voice' => 'Project created', 'accent' => 'random', 'voice_strength' => '100', 'voice_phase_in_timespan' => nil, 'voice_phase_in_start' => nil },
  ]

  # blog.corsego.com/turbo-hotwire-broadcasts
  after_create_commit do
    if activityble?
      broadcast_prepend_to("backend_regular_user_activity_#{record.id}_stream", target: "activity_#{record.id}", partial: "events/activity", locals: { event: self })
    end
    if toastable?
      broadcast_prepend_to('backend_regular_user_toast_stream', target: 'silica-toasts', partial: "events/toast", locals: { event: self  })      
    end
  end

  def record
    record_type.constantize.find(record_id)
  end

  def definition
    DEFINITIONS.select{|x| x['category'] == category }.first
  end

  def activityble?
    definition['activity'] == '1'
  end

  def toastable?
    definition['activity'] == '1'
  end

  def color
    "text-#{definition['color']}"
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
