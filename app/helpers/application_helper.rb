# frozen_string_literal: true

# To use or not to use draper: https://thepugautomatic.com/2014/03/draper/
module ApplicationHelper
  include PrettyDate
  include PrettyMoney

  def apollo_error_indication(record, col)
    record.errors.include?(col) ? 'is-invalid' : ''
  end

  def generate_instance_id
    SecureRandom.hex[0..6]
  end

  def project_direction_icon(project)
    project.direction == 'Outbound' ? 'fa-sign-out-alt' : 'fa-sign-in-alt'
  end

  # Goals:
  # Hitting reload in dev env should not make external network requests for images
  # Ability to specify rails env specific assets
  # Namespacing of assets using the COMPANY constant
  # Static browsing of source code shows the company name acme
  def silica_bucket(file_or_path, rails_env: 'neutral')
    "#{BUCKET_HOST}/#{COMPANY_LC}/#{rails_env}#{file_or_path}"
  end

  def silica_neutral_bucket(file_or_path, rails_env: 'neutral')
    "#{BUCKET_HOST}/neutral/#{rails_env}#{file_or_path}"
  end

  def status_icon(status)
    if status == 'Completed Won'
      '<i class="far fa-check-circle" data-bs-toggle="tooltip" data-bs-placement="top" title="Won" data-controller="apollo-tooltip"></i>'.html_safe
    elsif status == 'Completed Closed/Lost'
      '<i class="far fa-times-circle" data-bs-toggle="tooltip" data-bs-placement="top" title="Closed/Lost" data-controller="apollo-tooltip"></i>'.html_safe
    else
      '<i class="far fa-circle fa-sm" data-bs-toggle="tooltip" data-bs-placement="top" title="Open" data-controller="apollo-tooltip"></i>'.html_safe
    end
  end

  def spacer(count=1)
    content_tag(:div, "".html_safe, class: '', style: 'height: 0.1rem') * count
  end

  def horizontal_spacer(count=1)
    content_tag(:div, "<!-- horizontal spacer -->".html_safe, class: 'd-inline-block me-1') * count
  end

  def silica_container(id=SecureRandom.hex[0..6], style: :basic, inline_css: "")
    content_tag(:div, id: id, class: "container #{current_area.style(style).classes}", style: inline_css) do
      content_tag(:div, class: 'row') do
        content_tag(:div, class: 'col') do
          if block_given?
            yield
          end
        end
      end
    end
  end

  def random_id
    "id-#{SecureRandom.hex[0..6]}"
  end

  def question_tooltip(message)
    "<i class=\"far fa-question-circle fa-xs\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"#{j message}\" data-controller=\"apollo-tooltip\"></i>".html_safe
  end

  def current_area
    raise 'Area Not Specified' unless @area
    @area
  end

  def inherit_style
    ['text-reset', 'silica-weight-reset']
  end

  # Undo some bootstrap styles
  def inherit_styles
    'text-reset silica-weight-reset'
  end

  # shows dash if present? is falsey
  def dashify(object)
    object.presence || '-'
  end

  def silica_date_picker_attributes
    "type='datetime-local' data-controller='submits-form-immediately' data-action='change->submits-form-immediately#submit_form'".html_safe
  end

  def button_style(size: '', rounding: '', classes: [])
    BOOTSTRAP_UPGRADE ? { class:  [ 'btn', size, rounding, 'border', 'btn-outline-light', 'text-reset', 'silica-weight-reset', 'shadow-sm', current_area.style(:basic).classes, classes ] } : { class: [ 'btn', 'btn-sm', 'btn-brandprimary', 'text-white', 'silica-rounded-0.5-i' ] }
  end

  def silica_anchor(url, size: '', rounding: 'rounded-3', data: nil)
    content_tag(:a, href: url, data: data, **button_style(size: size)) do
      yield
    end
  end

  def silica_button(type: 'submit', label: 'Testing', size: '', classes: [], rounding: 'rounded-3', name: '', value: '', form: '', disabled: nil, data: nil)
    button_tag(type: type, name: name, value: value, form: form, data: data, disabled: disabled, **button_style(size: size, rounding: rounding, classes: classes)) do
      content_tag(:div) do
        yield
      end
    end
  end
end
