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
    'mbo-background' if @area&.menu_mode == 'mop' || @menu_mode == 'mop'
  end

  def prevent_scrolling_maybe
    '' if @area&.menu_mode == 'mop' || @menu_mode == 'mop'
  end

  def apollo_font
    @poppins == true || @area&.poppins? ? 'brand-font' : ''
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
      '<i class="far fa-check-circle text-warning"></i>'.html_safe
    elsif status == 'Completed Closed/Lost'
      '<i class="far fa-times-circle"></i>'.html_safe
    else
      '<i class="far fa-circle"></i>'.html_safe
    end
     
  end
end

