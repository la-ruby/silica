FactoryBot.define do
  factory :event do
  end

  trait :project_creation do
    category { 'project_creation' }
    timestamp { Time.now }
    record_id { Project.first.id }
    record_type { 'Project' }
    inventor_id { User.first.id }
  end
end
