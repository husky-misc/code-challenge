FactoryBot.define do
  factory :frag do
    player
    gun
    match
    date { Time.now }
  end
end