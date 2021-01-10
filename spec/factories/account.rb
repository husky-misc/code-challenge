FactoryBot.define do
  factory :account do
    customer_id { build(:customer) }
  end
end
