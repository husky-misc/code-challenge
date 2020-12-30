FactoryBot.define do
  factory :transaction do
    credit_card
    status { %i[paid failed refunded dispute].sample }
    amount { rand(100..100_000) }
    currency { 'usd' }
  end
end
