FactoryBot.define do
  factory :match do
    trait :started do
      match_id  { Faker::Number.number(digits: 10).to_s }
      start     { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
      file      { fixture_file_upload(Rails.root.join('spec', 'support', 'complete_match_log'), 'log') }
    end

    trait :finished do
      finish { Faker::Time.between(from: start, to: start + 5.minutes) }
    end

    factory :started_match, traits: [:started]
    factory :finished_match, traits: [:started, :finished]
  end
end
