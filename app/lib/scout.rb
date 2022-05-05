# frozen_string_literal: true

# Property Inspection links are generated by integrating with a third party api
class Scout
  # Generates a scout url by calling remote api
  def self.generate(project)
    uri = URI.parse(INSPECTION_SERVICE_URL)
    req = Net::HTTP.new(uri.hostname, uri.port)
    req.use_ssl = true
    Rails.logger.info ">> #{INSPECTION_SERVICE_URL} D3BUG"
    res = req.post(
      uri.path,
      {
        auth: auth,
        clientid: INSPECTION_SERVICE_CLIENT_ID,
        reportaction: 'create',
        address: project.street,
        city: project.city,
        state: project.two_letter_state,
        zip: project.zip,
        producttype: 'Scout',
        productid: 'PDAv1',
        userid: INSPECTION_SERVICE_USER_ID,
        jsondata: {
          homeownerEmail: project.email,
          deliveryEmail: SILICA_SUPPORT
        }
      }.to_json,
      {
        'Content-Type' => 'application/json',
        "Accept" => "application/json" })
    Rails.logger.info "<< #{res.inspect} D3BUG"
    Rails.logger.info "<< #{res.body} D3BUG"
    raise 'Error 1651786261' if res.body.strip.size != 36 # sanity check
    return "https://#{INSPECTION_SERVICE_URL2}/sso/#{INSPECTION_SERVICE_CLIENT_ID}/#{INSPECTION_SERVICE_USER_ID}/#{res.body.strip}/#{CGI.escape(auth)}"
  end

  def self.auth
    encrypt_aes("#{INSPECTION_SERVICE_USERNAME}|#{INSPECTION_SERVICE_PASSWORD}|#{Time.now.utc.strftime("%FT%T %z")}|ref#{SecureRandom.hex[0..6]}|loanno").gsub("\n",'')
  end

  # copied from elsewhere
  def self.encrypt_aes(plain)
    inputkey = INSPECTION_SERVICE_KEY + INSPECTION_SERVICE_USER_ID
    inputiv = INSPECTION_SERVICE_CLIENT_ID

    # Encryption
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt

    key_iv = OpenSSL::PKCS5.pbkdf2_hmac_sha1(inputkey, inputiv, 1000, cipher.key_len+cipher.iv_len)
    key = key_iv[0, cipher.key_len]
    iv  = key_iv[cipher.key_len, cipher.iv_len]

    cipher.key = key
    cipher.iv = iv

    encrypted = cipher.update(plain) + cipher.final
    Base64.encode64(encrypted)
  end
end
