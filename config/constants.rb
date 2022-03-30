#
# Regular
#
APOLLO_INTERNAL_PRODUCTION = (ENV['INTERNAL_PRODUCTION'] == "1")
APOLLO_IP_PREFIX = (APOLLO_INTERNAL_PRODUCTION ? "internal-production." : "")
APOLLO_EPOCH = Time.at(1356480000)
WALGREENS = [ # For seeding
  { address: '1315 N State St, Provo, UT 84604', lat: 40.25173330094279, lng: -111.6689135775317 },
  { address: '850 S State St, Orem, UT 84097', lat: 40.281881143847244, lng: -111.68894994500074 },
  { address: '763 N State St, Orem, UT 84057', lat: 40.31111450352144, lng: -111.70186906034108 },
  { address: '815 W State St, Pleasant Grove, UT 84062', lat: 40.36597209423687, lng: -111.7526519738333 },
]
DEFAULT_LISTING_SEARCH_PARAMS = {
          q: '',
          beds: 'any',
          baths: 'any',
          sort: 'any',
          page: '1',
          map: '0'
        }
OPPORTUNITY_TYPES = {
  'opportunity_investment' => 'Opportunity Investment',
  'on_market' => 'On Market',
  'turn_key_rental' => 'Turn-Key Rental',
  'assignable_contract' => 'Assignable Contract'
}
LISTINGS_ZOOM_REDUCTION="75%"
DOCU_SIGN_BASE_PATH = 'https://na3.docusign.net/restapi'

#
# Overridable
#
{
  'APOLLO_PURCHASER_NAME' => "John Doe",
  'APOLLO_PURCHASER_PHONE' => "(111) 111-1111",
  'APOLLO_PURCHASER_PHONE_ALT' => '111-111-1111',
  'APOLLO_PURCHASER_EMAIL' => "test@example.com",
  'APOLLO_NAME' => "Acme",
  'APOLLO_NAKED_DOMAIN' => 'silica.com',
  'APOLLO_BACKEND_DOM' => 'backend.silica.com',
  'APOLLO_MBO_DOM' => 'portal.mysilicaoffer.com',
  'APOLLO_MBO_NAKED_DOM' => 'mysilicaoffer.com',
  'APOLLO_MARKETPLACE_DOM' => 'app.silicamarket.io',
  'APOLLO_MARKETPLACE_NAKED_DOM' => 'silicamarket.io',
  'STANDARD_FONT_URL' => 'https://use.typekit.net/testing.css',
  'PURCHASER_ENTITY' => 'Purchaser',
  'PURCHASER_ENTITY_ALT' => 'The Purchaser',
  'CALENDAR_URL' => 'https://calendar.google.com/calendar/embed?src=testing&ctz=America%2FDenver&bgcolor=%23F3F5F8',
  'WEBFLOW_COLLECTION' => 'testing-collection',
  'WEBFLOW_LOCATION_CODE' => 'testing-location',
  'WEBFLOW_PROPERTY_AGENT' => 'testing-agent',
  'SENDGRID_DESIGN' => 'testing-design',
  'SENDGRID_TEMPLATE_ADDENDUM' => 'd-testing',
  'SENDGRID_TEMPLATE_REPC' => 'd-testing',
  'SENDGRID_TEMPLATE_OFFER_REJECTED' => 'd-testing',
  'SENGRID_SENDER_ID' => 12345,
  'SENDGRID_SUPPRESSION_GROUP_ID' => 12345,
  'SENDGRID_MARKETING_LIST_ID' => 'testing',
  'DOCU_SIGN_INTEGRATOR_KEY' => 'testing',
  'DOCU_SIGN_USER_ID' => 'testing',
  'DOCU_SIGN_ACCOUNT_ID' => 'testing',
  'DOCU_SIGN_REPC_TEMPLATE' => 'testing',
  'DOCU_SIGN_REPC_TEMPLATE_DUAL' => 'testing',
  'APOLLO_DOCUSIGN_ADDENDUM_TEMPLATE_ID' => 'testing',
  'APOLLO_ADMIN_LOGIN' => 'testing.developer.1@silica.com',
  'APOLLO_CDN' => 'http://localhost:4000',
  'APOLLO_GOOGLE_MAPS_API_KEY' => 'testing',
  'COMPANY_UC' => 'ACME',
  'COMPANY_LC' => 'acme',
  'COMPANY' => 'Acme',
  'LIMITED_USER1' => 'limited1@silica.com',
  'LIMITED_USER2' => 'limited2@silica.com',
  'APOLLO_DISCLAIMER' => ('testing ' * 30),
  # dummy from https://travistidwell.com/jsencrypt/demo/  
  'DOCU_SIGN_PRIVATE_KEY' => "-----BEGIN RSA PRIVATE KEY-----\nMIICWwIBAAKBgQCvPMPuwr9lBe6ZODR9UGLgOEkI1kM+VBV27QUd1ut3ZzSlvgFd\nu7zSSupc9D9Xs1H1pR+KlodZkqMGD88fI1UdkapmlGe65jZIS66DxgsfSr5DHKKW\nMJm4CiKhcK3Ss2FvhbYE7AZgUAjM34fyQdYVN9jrqoZkTdJX9dhZNSnI2wIDAQAB\nAoGAEH4PkrERgliElDcN+Z1PMPsbJJHF0l/nhUHZcW2Ay8QS2GaBimjY5JHYbNcv\n/vkJhaz8wvZX1r5OSYvDWpLgt7ds7VdaYY0nIjObFF++bGF/H2vo5eJAtm1reZKN\nCm8hzKzg/aLBmCSDeQnRZ8dfLC5HPhzxUTfrnpbLmczy6IECQQD0uXo4/8xMmmWZ\nFJ5xQd2v8igQZRsdLCZFGqGTLpIdDndpcu64PIDmsoIrNrbuclBz2s/sxa7zJ5tQ\nBf134CcTAkEAt0+wFLGbRzxJLuVE1ykLJ29t7lf4H3CHjdWSYAt/KzuRkOdXIDr6\nDYuE7FR8X2L1BEP8WylgTS9IALVyS4koGQJAcej3nBps1Oc1DTkMuvkGoEQeI+t7\n4GtRcO8BcEnIFyBJstqdhUIcWcWTU1wHcBvjmNmr2LD3SxUPdQMkxSyf4wJAZwWC\nEB9BBWf8OT7g0YtfmWomfi0yZXj4td2xxgiwD7wKs0VQ0exTXAltSuSwgWs8CIms\n6g728GoCLWPMOGd9AQJACxa703MPIVV543Cdb92QpO7+ccc3Ta103CYHFImTOGUu\ncXlfaMtFVhbM2Z4TOXV32isxmqRJgv5kFsngft4Hdw==\n-----END RSA PRIVATE KEY-----",
  'APOLLO_UTAH_LIVE_MAILING_LIST' => 'testing',
  'APOLLO_NC_LIVE_MAILING_LIST' => 'testing',
  'APOLLO_UTAH_DUMMY_MAILING_LIST' => 'testing',
  'APOLLO_NC_DUMMY_MAILING_LIST' => 'testing',
  'SENDGRID_API_KEY' => 'testing',
  'SENDGRID_API_KEY2' => 'testing',
  'APOLLO_ADMIN_PASSWORD' => 'password',
  'WEBFLOW_API_KEY' => 'testing',
  'AWS_ACCESS_KEY_ID' => 'testing',
  'AWS_SECRET_ACCESS_KEY' => 'testing',
  'ROLLBAR_ACCESS_TOKEN' => 'testing',
  'APOLLO_HEROKU_APP' => 'testing',
  'BUCKET_HOST' => 'https://silica-bucket.s3.amazonaws.com'
}.each do |k,v|
  Object.const_set(
    k,
    ENV[k] || v) 
end


#
# Regular
#
APOLLO_BACKEND_FULL_DOMAIN = "https://#{APOLLO_IP_PREFIX}#{APOLLO_BACKEND_DOM}"
APOLLO_BACKEND_DOMAIN = "#{APOLLO_IP_PREFIX}#{APOLLO_BACKEND_DOM}"
APOLLO_MARKETPLACE_FULL_DOMAIN = "https://#{APOLLO_IP_PREFIX}#{APOLLO_MARKETPLACE_DOM}"
APOLLO_PORTAL_FULL_DOMAIN = "https://#{APOLLO_IP_PREFIX}#{APOLLO_MBO_DOM}"
SILICA_SUPPORT = "friends@#{APOLLO_NAKED_DOMAIN}"
LIMITED_USERS = [ LIMITED_USER1, LIMITED_USER2 ]
APOLLO_UTAH_MAILING_LIST = (APOLLO_INTERNAL_PRODUCTION ? APOLLO_UTAH_DUMMY_MAILING_LIST : APOLLO_UTAH_LIVE_MAILING_LIST)
APOLLO_NC_MAILING_LIST = (APOLLO_INTERNAL_PRODUCTION ? APOLLO_NC_DUMMY_MAILING_LIST : APOLLO_NC_LIVE_MAILING_LIST)

