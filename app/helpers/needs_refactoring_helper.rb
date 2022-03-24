# frozen_string_literal: true

# it might be easier to get rid of these helpers
# than to refactor them
module NeedsRefactoringHelper
  # TODO: partialize
  def apollo_popover(content)
    "<a data-controller='popover' tabindex='0' class='popover-dismiss' role='button' data-bs-toggle='popover' data-bs-trigger='focus' title='' data-bs-content='#{content}'>#{feather_icon(
      'info', height: '13px'
    )}</a>".html_safe
  end

  # TODO: remove
  def older_cdn_path(path)
    "#{APOLLO_CDN}#{path}"
  end

  def status_badge(str)
    color = case str
            when 'Open'
              'primary'
            when 'Completed Closed/Lost'
              'danger'
            when 'Completed Won'
              'success'
            else
              'dark'
            end
    "<span class='badge bg-#{color}'>#{str}</span>".html_safe
  end

  def status_color(status)
    result = 'primary'
    case status
    when 'Completed Closed/Lost'
      result = 'danger'
    when 'Completed Won'
      result = 'success'
    end
    result
  end

  # TODO: partialize?
  def feather_icon(icon, options = {})
    style = "style='height: #{options[:height]}'" if options[:height]
    "<svg class='feather-icon' #{style}>" \
    "<use xlink:href='/feather-sprite.svg##{icon}' />" \
    '</svg>'.html_safe
  end
end
