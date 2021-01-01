FactoryBot.define do
  factory :credit_card do
    account
    spent_limit { rand(100..100_000) }
    number { FFaker::Bank.card_number }
    expiration_date { FFaker::Bank.card_expiry_date }
    cvv { FFaker.numerify('###') }
  end
end
