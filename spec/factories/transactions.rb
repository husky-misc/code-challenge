FactoryBot.define do
  factory :transaction do
    credit_card
    status { :started }
    amount { rand(100..100_000) }
    currency { 'usd' }
  end
end
