FactoryBot.define do
  factory :transaction do
    credit_card { build(:credit_card) }
    currency { 'usd' }
    amount { '50000' }
  end
end
