module WebmockTestHelpers
  def stub_sendgrid_export
    stub_request(:post, 'https://api.sendgrid.com/v3/marketing/contacts/exports')
      .to_return(status: 202,
                 body: {id: 'testing'}.to_json,
                 headers: {})
  end

  def stub_sendgrid_export_step2
    stub_request(:get, 'https://api.sendgrid.com/v3/marketing/contacts/exports/testing')
      .to_return(status: 200,
                 body: {status: 'ready', urls: ['http://example.com/testing'] }.to_json,
                 headers: {})
  end

  def stub_sendgrid_export_step3
    stub_request(:get, 'http://example.com/testing')
      .to_return(status: 200,
                 body: '{"address_line_1":"123 Main Street","city":"Layton","contact_id":"testing-hex","created_at":"2021-04-26T23:16:58Z","custom_fields":{"company":"Testing","investing_location":"-UT-","legacy_lists":"testing","permission_type":"Implied","phone_work":"123-123-1234","source":"Added by you"},"email":"testing.1648134462@example.com","first_name":"John","last_name":"Doe","postal_code":"90210","state_province_region":"UT","updated_at":"2022-02-05T06:58:20Z"}',
                 headers: {})
  end

  def stub_sendgrid_marketing_lists
    stub_request(:get, 'https://api.sendgrid.com/v3/marketing/lists')
      .to_return(status: 200, body: {
                   result: [
                     { id: SENDGRID_MARKETING_LIST_ID } ]
                 }.to_json, headers: {})
  end

  def stub_sendgrid_marketing_contacts
    stub_request(:get, 'https://api.sendgrid.com/v3/marketing/contacts')
      .to_return(status: 200, body: {result: [
                                       list_ids: [ SENDGRID_MARKETING_LIST_ID ],
                                       created_at: "2022-02-05T06:58:20Z"
                                     ]}.to_json, headers: {})
  end

  def stub_sendgrid_contacts_put
    stub_request(:put, 'https://api.sendgrid.com/v3/marketing/contacts')
      .to_return(status: 200, body: {}.to_json, headers: {})
  end

  def stub_docusign_token_request
    stub_request(
      :post,
      'https://account.docusign.com/oauth/token'
    ).to_return(
      status: 200,
      body: {"access_token":"testing","token_type":"Bearer","expires_in":3600}.to_json,
      headers: {}
    )
  end

  def stub_docusign_status_request
    stub_request(
      :put,
      'https://na3.docusign.net/restapi/v2.1/accounts/' \
      'testing/envelopes/status?from_date=2012-12-22&status=completed'
    ).to_return(
      status: 200,
      body: '{"resultSetSize":"1","startPosition":"0","endPosition":"0","tot' \
            'alSetSize":"1","nextUri":"","previousUri":"","envelopes":[{"sta' \
            'tus":"completed","documentsUri":"/envelopes/testing/documents",' \
            '"recipientsUri":"/envelopes/testing/recipients","attachmentsUri' \
            '":"/envelopes/testing/attachments","envelopeUri":"/envelopes/te' \
            'sting","envelopeId":"testing","customFieldsUri":"/envelopes/tes' \
            'ting/custom_fields","notificationUri":"/envelopes/testing/notif' \
            'ication","statusChangedDateTime":"2022-03-04T20:22:08.1770000Z"' \
            ',"documentsCombinedUri":"/envelopes/testing/documents/combined"' \
            ',"certificateUri":"/envelopes/testing/documents/certificate","t' \
            'emplatesUri":"/envelopes/testing/templates","anySigner":null,"e' \
            'nvelopeLocation":null}]}',
      headers: {}
    )
  end

  def stub_docusign_recipient_views_request
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes/68027dbd-142c-4f7a-a4a2-89e10fdd41f3/views/recipient").to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})
  end

  def stub_docusign_recipient_views_request_alternative
    stub_request(:post, 'https://na3.docusign.net/restapi/v2.1/accounts/testing/envelopes/68027dbd-142c-4f7a-a4a2-89e10testing/views/recipient').to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})
  end

  def stub_docusign_recipient_views_request_3
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/testing/envelopes/testing/views/recipient").to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})
  end

  def stub_docusign_recipient_views_request_4
    stub_request(:post, 'https://na3.docusign.net/restapi/v2.1/accounts/testing/envelopes//views/recipient').to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})
  end

  def stub_docusign_envelope_creation
    stub_request(:post, 'https://na3.docusign.net/restapi/v2.1/accounts/testing/envelopes').to_return(status: 200, body: {"envelopeId":"68027dbd-142c-4f7a-a4a2-89e10testing","uri":"/envelopes/68027dbd-142c-4f7a-a4a2-89e10testing","statusDateTime":"2022-01-17T15:54:31.2800000Z","status":"sent"}.to_json, headers: {})
  end


  def stub_sendgrid_mail
    stub_request(:post, "https://api.sendgrid.com/v3/mail/send").to_return(status: 200, body: "", headers: {'x-message-id'=>'example'})
  end

  def stub_sendgrid_mail2(token:)
    stub_request(:post, "https://api.sendgrid.com/v3/mail/send").
      with(
        body: "{\"personalizations\":[{\"to\":[{\"email\":\"testing@example.net\"}],\"bcc\":[{\"email\":\"example.developer.1@example.com\"}],\"dynamic_template_data\":{\"id\":\"unusedLegacy\",\"signer\":\"unusedLegacy\",\"token\":\"#{token}\",\"name\":\"Testing\",\"representative\":{\"name\":\"#{APOLLO_PURCHASER_NAME}\",\"email\":\"#{APOLLO_PURCHASER_EMAIL}\",\"phone\":\"(111) 222-3333\"},\"apollo_full_domain\":\"http://dev.aaa.bbb.com:2999\",\"street\":\"1234 Main Street\"}}],\"from\":{\"email\":\"#{COMPANY} \\u003cfriends@example.com\\u003e\"},\"template_id\":\"d-d20420adddac4248a08203be11af2b0b\",\"mail_settings\":{\"sandbox_mode\":{\"enable\":true}}}").
      to_return(status: 200, body: "", headers: {'x-message-id'=>'example'})

  end
end

