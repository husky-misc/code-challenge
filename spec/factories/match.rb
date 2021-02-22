FactoryBot.define do
  factory :match do
    match_id { "1234" }
    start_date { Time.now }
    end_date { nil }
  end
end