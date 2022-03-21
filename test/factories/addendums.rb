FactoryBot.define do
  factory :addendum do
    version { "1" }
    expiration { "2017-01-17T12:31:26.695+11:00" }
    deadline { "2017-01-27T12:31:26.695+11:00" }
    terms {
      "Lorem Ipsum is simply dummy text of the printing and typesetting
      industry. Lorem Ipsum has been the industry's standard dummy text ever
      since the 1500s, when an unknown printer took a galley of type and
      scrambled it to make a type specimen book. It has survived not only
      five centuries, but also the leap into electronic typesetting,
      remaining essentially unchanged. It was popularised in the 1960s with
      the release of Letraset sheets containing Lorem Ipsum passages, and
      more recently with desktop publishing software like Aldus PageMaker
      including versions of Lorem Ipsum."
    }
    status { "Ready" }

    project
  end
end
