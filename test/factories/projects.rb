FactoryBot.define do
  factory :project do
    name { "John Doe" }
    direction { "Inbound" }
    status { "Open" }
    street { "1234 Main Street" }
    street2 { "Apt 101" }
    city { "Testcity" }
    state { "Utah" }
    zip { "90210" }
    phone { "(310) 123-4567" }
    email { "example@example.com" }
    req_date { Time.now.iso8601 }

    trait :has_second_seller do
      secondName { 'Jane Doe' }
      secondEmail { 'example2@example.com' }
      secondPhone { '(310) 123-4568' }
    end

    trait :has_av do
      after(:create) do |project, evaluator|
        addendum = Addendum.create(
          addendum_number: Addendum.next_addendum_number(project),
          project_id: project.id
        )
        addendum_version = AddendumVersion.create(
          addendum_id: addendum.id,
          version:  1,
          mop_token: SecureRandom.hex,
          status: 'Draft',
          related_repc_id: project.repcs.last.id
        )
      end
    end

    trait :has_listed do
      after(:create) do |project, evaluator|
        project.listing.update(listed: 'true')
      end
    end

    trait :has_webflow_id do
      after(:create) do |project, evaluator|
        project.listing.update(webflow_id: 'testing')
      end
    end

    trait :has_envelope do
      after(:create) do |project, evaluator|
        project.repc.update(docusign_envelope_id: "testing")
      end
    end
  end
end
