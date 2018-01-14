FactoryBot.define do
  factory :ip do
    address    "1.1.1.1"
    values     [1,2,3]
    computed   false
  end
end