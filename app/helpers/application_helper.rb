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

  def background_with_image
    'mbo-background' if @zrea&.menu_mode == 'mop' || @menu_mode == 'mop'
  end

  def prevent_scrolling_maybe
    '' if @zrea&.menu_mode == 'mop' || @menu_mode == 'mop'
  end

  def apollo_font
    @poppins == true || @zrea&.poppins? ? 'brand-font' : ''
  end

  # Goals:
  # Hitting reload in dev env should not make external network requests for images
  # Ability to specify rails env specific assets
  # Namespacing of assets using the COMPANY constant
  # Static browsing of source code shows the company name acme
  def silica_bucket(file_or_path, rails_env: 'neutral', brand: 'neutral')
    server = (Rails.env.production? ? 'https://silica-bucket.s3.amazonaws.com' : 'http://localhost:5000')
    "#{server}/#{brand}/#{rails_env}#{file_or_path}"
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
    content_tag(:div, "&nbsp;".html_safe, class: 'mb-1') * count
  end

  def container
    content_tag(:div, class: 'container') do
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
end

