FactoryBot.define do
  factory :user do
    password { 'testing' }
    email { 'example@example.com' }
    permissions { ['reader', 'writer' ] }

    trait :staff do
      email { APOLLO_ADMIN_LOGIN }
    end
  end
end
