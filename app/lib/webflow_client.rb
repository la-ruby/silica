# frozen_string_literal: true

# To Communicate with Webflow API
class WebflowClient
  # :reek:ControlParameter
  # :reek:DuplicateMethodCall
  # :reek:TooManyStatements
  def self.request(url, method, body)
    uri = URI(url)
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      req = if method == :delete
              Net::HTTP::Delete.new(uri)
            else
              Net::HTTP::Post.new(uri)
            end
      req['Content-Type'] = 'application/json'
      req['accept-version'] = '1.0.0'
      req['Authorization'] = "Bearer #{WEBFLOW_API_KEY}"
      req.body = body.to_json
      Rails.logger.info ">> #{req.body}"
      response = (APOLLO_INTERNAL_PRODUCTION ? nil : http.request(req))
      Rails.logger.info "<< #{response.class} #{response.body}"
      JSON.parse(response.body)['_id']
    end
  end
end
