FactoryBot.define do
  factory :match do
    association :ranking

    frags { 50 }
    started_at { '2021-05-15 08:30' }
    ended_at { '2021-05-15 09:30' }
    winner { 50 }
    content { 50 }
    strike_player { 50 }
  end
end
