FactoryBot.define do
  factory :play do
    association :match, factory: :finished_match
    association :killer, factory: :player
    association :victim, factory: :player
    association :weapon, factory: :weapon
    gametime { Faker::Time.between(from: match.start, to: match.finish) }
  end
end
