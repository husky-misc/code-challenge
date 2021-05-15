FactoryBot.define do
  factory :ranking, class: '::Ranking' do
    association :log
    status { :processed }
    processed_at { Time.zone.now }
  end
end
