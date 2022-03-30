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
    'mbo-background' if current_area.is_a?(Area::Offer)
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
    content_tag(:div, "&nbsp;".html_safe, class: 'mb-1') * count
  end

  def horizontal_spacer(count=1)
    content_tag(:div, "<!-- horizontal spacer -->".html_safe, class: 'd-inline-block me-1') * count
  end

  def basic_container(style: :basic)
    content_tag(:div, class: "container #{current_area.style(style).classes}") do
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

  def experiment
    Rails.cache.fetch("v1/experimemt", expires_in: 5.minutes) do
          # TODO: Refactor / optimize / cache
          uri = URI.parse(CHART_SERVICE_HOST)
          req = Net::HTTP.new(uri.hostname, uri.port)
	  req.use_ssl = true
           req.read_timeout = 300000
          xml_data = %{<avmx>
  <request type="complexityprofiler" transferinfo="true" compTransferInfo="true" dataSource="mls" pdfReport="true" subjectDataSource="mlsdq" compsType="distancenozip" chartsEmbedded="true" refi="true" mlssupplementalinfo="true" marketconditions="true" avmforecast="true">
    <requestheader>
      <timestamp>0001-01-01T00:00:00</timestamp>
      <metainfo name="transactionid" value="" />
      <metainfo name="parent_sqn" value="0" />
      <account>
        <userid>#{CHART_SERVICE_USERNAME}</userid>
        <password>#{CHART_SERVICE_PASSWORD}</password>
      </account>
    </requestheader>
    <property>
      <address>
        <fulladdress>5202 Downey Ave</fulladdress>
        <city>Lakewood</city>
        <state>CA</state>
        <zip>90712</zip>
      </address>
    </property>
    <searchcriteria maxdistance="2">
      <complookuprange>
      <low>0</low>
      <high>12</high>
      </complookuprange>
      <areafocus />
    </searchcriteria>
  </request>
</avmx>}
          res = req.post(uri.path, xml_data, {'Content-Type' => 'application/xml', "Accept" => "application/xml" })
          res.body
    end
  end
end

