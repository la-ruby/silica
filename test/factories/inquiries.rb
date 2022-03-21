FactoryBot.define do
  factory :inquiry do
    name { "Testing" }
    email { "Testing" }
    phone { '111-111-1111' }
    url { 'https://example.com' }
    ip { '1.1.1.1' }
  end
end
