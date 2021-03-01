# frozen_string_literal: true

FactoryBot.define do
  factory :match do
    game
    match_id { 1 }
    ranking { '' }
    started_at { '2021-02-28 22:07:41' }
    finished_at { '2021-02-28 22:07:41' }
  end
end
