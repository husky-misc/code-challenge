FactoryBot.define do
  factory :compute_history do
    ips { [create(:ip)] }
    computed_at { Time.now }
  end
end
