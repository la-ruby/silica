FactoryBot.define do
  factory :contact do
    first_name { 'testing' }
    last_name { 'testing' }
    email { 'testing@example.com' }
    investing_location { '-UT-' }
    sendgrid_created_at { '2021-04-26T23:16:58Z' }
    sendgrid_created_at_searchable { '04/26' }
  end
end
