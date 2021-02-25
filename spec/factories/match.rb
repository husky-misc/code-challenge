FactoryBot.define do
  factory :match do
    trait :started do
      match_id    { Faker::Number.number(digits: 10).to_s }
      match_begin { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    end

    factory :started_match, traits: [:started]
  end
end
