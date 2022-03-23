# frozen_string_literal: true

module PrettyDate
  # Converts iso/iso8601 style date strings to
  # various formats
  def apollo_date(obj)
    result = obj
    return result unless obj.present?
    return result unless obj.is_a?(String)

    Date.strptime(obj, '%Y-%m-%d')
        .strftime('%m-%d-%Y, %H:%M %p')
  rescue Date::Error
    obj
  end

  # has no time
  def apollo_date2(obj)
    result = obj
    return result unless obj.present?
    return result unless obj.is_a?(String)

    Date.strptime(obj, '%Y-%m-%d')
        .strftime('%m-%d-%Y')
  rescue Date::Error
    obj
  end

  # has only time in 12Hour HH:MM XM format
  def apollo_date4(obj)
    result = obj
    return result unless obj.present?
    return result unless obj.is_a?(String)

    DateTime.strptime(obj, '%H:%M')
            .strftime('%l:%M %p')
  rescue Date::Error
    obj
  end

  # has no time, more readibility
  def apollo_date3(obj)
    result = obj
    return result unless obj.present?
    return result unless obj.is_a?(String)

    Date.strptime(obj, '%Y-%m-%d')
        .strftime('%B %d, %Y')
  rescue Date::Error
    obj
  end

  def apollo_date5(obj)
    DateTime.iso8601(obj).strftime('%Y-%m-%dT%R')
  rescue StandardError
    ''
  end

  def apollo_date6(obj)
    (begin
      DateTime.iso8601(obj).strftime('%H:%M')
    rescue StandardError
      nil
    end || '-')
  end
end
