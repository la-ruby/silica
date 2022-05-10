class Event < ApplicationRecord
  # Definitions, activity here stands refers to the activity feed tab
  DEFINITIONS = [
    { 'category' => 'project_creation',      'color' => 'primary',   'toast' => '1', 'toast_stength' => '100', 'activity' => '1', 'confetti' => '1', 'confetti_strength' => '100', 'confetti_phase_in_timesan' => nil, 'confetti_phase_in_start' => nil, 'voice' => 'Project created',         'voice_strength' => '100', 'voice_phase_in_timespan' => nil, 'voice_phase_in_start' => nil, 'accent' => 'random' },
    { 'category' => 'comment_added',         'color' => 'secondary', 'toast' => '1', 'toast_stength' => '100', 'activity' => '1', 'confetti' => '0', 'confetti_strength' => nil,   'confetti_phase_in_timesan' => nil, 'confetti_phase_in_start' => nil, 'voice' => 'Comment added',           'voice_strength' => '100', 'voice_phase_in_timespan' => nil, 'voice_phase_in_start' => nil, 'accent' => 'it_IT_Alice,sv_SE_Alva,de_DE_Anna,en_GB_Daniel,nl_BE_Ellen,en-scotland_Fiona,pt_PT_Joana,en_AU_Karen,ja_JP_Kyoko,it_IT_Luca,ru_RU_Milena,en_IE_Moira,en_US_Samantha,fi_FI_Satu,en_US_Victoria' },
    { 'category' => 'repc_signed',           'color' => 'success',   'toast' => '1', 'toast_stength' => '100', 'activity' => '1', 'confetti' => '0', 'confetti_strength' => nil,   'confetti_phase_in_timesan' => nil, 'confetti_phase_in_start' => nil, 'voice' => 'Repcee signed',           'voice_strength' => '100', 'voice_phase_in_timespan' => nil, 'voice_phase_in_start' => nil, 'accent' => 'en-scotland_Fiona,en_US_Victoria' },
    { 'category' => 'repc_signed_by_seller', 'color' => 'danger',    'toast' => '1', 'toast_stength' => '100', 'activity' => '1', 'confetti' => '1', 'confetti_strength' => '100', 'confetti_phase_in_timesan' => nil, 'confetti_phase_in_start' => nil, 'voice' => 'Repcee signed by seller', 'voice_strength' => '100', 'voice_phase_in_timespan' => nil, 'voice_phase_in_start' => nil, 'accent' => 'en-scotland_Fiona,en_US_Victoria' },
    { 'category' => 'offer_viewed',          'color' => 'warning',   'toast' => '1', 'toast_stength' => '100', 'activity' => '1', 'confetti' => '1', 'confetti_strength' => '100', 'confetti_phase_in_timesan' => nil, 'confetti_phase_in_start' => nil, 'voice' => 'Offer viewed by seller',  'voice_strength' => '100', 'voice_phase_in_timespan' => nil, 'voice_phase_in_start' => nil, 'accent' => 'it_IT_Alice,sv_SE_Alva,de_DE_Anna,en_GB_Daniel,nl_BE_Ellen,en-scotland_Fiona,en_AU_Karen,it_IT_Luca,ru_RU_Milena,en_IE_Moira,en_US_Samantha,fi_FI_Satu,en_US_Victoria' },
    { 'category' => 'file_added',            'color' => 'primary',   'toast' => '1', 'toast_stength' => '100', 'activity' => '1', 'confetti' => '0', 'confetti_strength' => nil,   'confetti_phase_in_timesan' => nil, 'confetti_phase_in_start' => nil, 'voice' => 'File added',              'voice_strength' => '100', 'voice_phase_in_timespan' => nil, 'voice_phase_in_start' => nil, 'accent' => 'random' },
    { 'category' => 'marketing_mail_sent',   'color' => 'dark',      'toast' => '1', 'toast_stength' => '100', 'activity' => '1', 'confetti' => '1', 'confetti_strength' => '100', 'confetti_phase_in_timesan' => nil, 'confetti_phase_in_start' => nil, 'voice' => 'Marketing mail sent',     'voice_strength' => '100', 'voice_phase_in_timespan' => nil, 'voice_phase_in_start' => nil, 'accent' => 'random' },
    { 'category' => 'listing_added',         'color' => 'info',      'toast' => '1', 'toast_stength' => '100', 'activity' => '1', 'confetti' => '0', 'confetti_strength' => nil,   'confetti_phase_in_timesan' => nil, 'confetti_phase_in_start' => nil, 'voice' => 'Listing added',           'voice_strength' => '100', 'voice_phase_in_timespan' => nil, 'voice_phase_in_start' => nil, 'accent' => 'random' },
    { 'category' => 'listing_removed',       'color' => 'light',     'toast' => '1', 'toast_stength' => '100', 'activity' => '1', 'confetti' => '0', 'confetti_strength' => nil,   'confetti_phase_in_timesan' => nil, 'confetti_phase_in_start' => nil, 'voice' => 'Listing removed',           'voice_strength' => '100', 'voice_phase_in_timespan' => nil, 'voice_phase_in_start' => nil, 'accent' => 'it_IT_Alice,sv_SE_Alva,de_DE_Anna,en_GB_Daniel,nl_BE_Ellen,en-scotland_Fiona,en_AU_Karen,it_IT_Luca,ru_RU_Milena,en_IE_Moira,en_US_Samantha,fi_FI_Satu,en_US_Victoria' },

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
    elsif inventor_id == -3
      SellerUser.new
    elsif inventor_id == -4
      SecondSellerUser.new
    # else
    #   NullUser.new
    end
  end
end
