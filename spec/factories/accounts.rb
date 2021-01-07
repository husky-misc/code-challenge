FactoryBot.define do
  factory :account do
    association(:customer, factory: :customer)
  end
end
