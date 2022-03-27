# frozen_string_literal: true

# :nodoc:
module ContactsHelper
  def investing_locations_pretty(string)
    string ? string.split('-').reject(&:empty?).join(', ') : ''
  end

  def direction_pretty(obj)
    case obj
    when 'desc'
      'descending'
    when 'asc'
      'ascending'
    end
  end
end
