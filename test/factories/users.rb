FactoryBot.define do
  factory :user do
    password { 'testing' }
    email { 'example@example.com' }

    trait :staff do
      email { APOLLO_ADMIN_LOGIN }
    end
  end
end
