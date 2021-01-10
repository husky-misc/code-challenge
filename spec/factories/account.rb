FactoryBot.define do
  factory :account do
    customer_id { create(:customer).id }
  end
end
