# frozen_string_literal: true

# Sometimes docusign redirects back to us, i call it webhook,
# might not fit the strict definition
class WebhooksController < ApplicationController
  protect_from_forgery except: :webhook

  def webhook
    par = params.to_unsafe_hash.slice('street', 'city', 'state', 'zip', 'name', 'phone', 'email', 'expectedTimeline')
    expected_timeline = par.delete('expectedTimeline')
    record = Project.new(
      expectedtimeline: expected_timeline, direction: 'Inbound', req_date: Time.now.iso8601,
      status: 'Open', **par
    )
    record.save
    render json: { message: 'ok' }, status: :ok
  end

  def webhook_signed_by_company
    return unless params[:event] == 'signing_complete'

    record = Repc.find_by_docusign_envelope_id envelope_id
    record ||= AddendumVersion.find_by_docusign_envelope_id(envelope_id)
    record.update(signed_by_company_at: Time.now.iso8601)
    redirect_to Base64.urlsafe_decode64(params[:original_url])
  end

  def webhook_revert
    aws_creds = "AWS_REGION='us-east-1' AWS_ACCESS_KEY_ID='#{AWS_ACCESS_KEY_ID}' AWS_SECRET_ACCESS_KEY='#{AWS_SECRET_ACCESS_KEY}'"
    `heroku pg:copy silica-#{APOLLO_HEROKU_APP}::DATABASE_URL DATABASE_URL -a silica-internal-#{APOLLO_HEROKU_APP} --confirm silica-internal-#{APOLLO_HEROKU_APP}` if Rails.env.production? && !APOLLO_INTERNAL_PRODUCTION
    muter = (Rails.env.production? ? "" : " echo ")
    Rails.logger.info `#{muter} #{aws_creds} aws s3 sync s3://#{COMPANY_LC}-web-app-production s3://#{COMPANY_LC}-web-app-internal-production --acl public-read`
    render plain: 'ok'
  end

  def webhook_sendgrid_event
    data = JSON.parse(request.body.read)
    Rails.logger.info "<< webhook_sendgrid_event #{data}"
    refresh_offer_viewed(data)
    render plain: 'ok'
  end

  private

  def envelope_id
    params[:envelope_id]
  end

  def refresh_offer_viewed(data)
    (data.select do |x|
      x['event'] == 'click'
     end).each do |event|
      event_sg_message_id = event['sg_message_id'].split('.')[0]
      Project.find_by_sendgrid_message_id(event_sg_message_id)
        &.update(offer_viewed: Time.at(event['timestamp']))
    end  
  end
end
