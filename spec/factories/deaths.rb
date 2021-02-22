FactoryBot.define do
  factory :death do
    player
    gun
    match
    date { Time.now }
  end
end