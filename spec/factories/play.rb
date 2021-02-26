FactoryBot.define do
  factory :play do
    association :match, factory: :ended_match
    association :killer, factory: :player
    association :victim, factory: :player
    association :weapon, factory: :weapon
    gametime { Faker::Time.between(from: match.match_begin, to: match.match_end) }
  end
end
