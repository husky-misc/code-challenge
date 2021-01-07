FactoryBot.define do
  factory :credit_card do
    association(:account, factory: :account)
    spent_limit { rand(100_00..100_000_00) }
    number { Faker::Finance.credit_card }
    expiration_date { Faker::Time.forward }
    cvv { Faker::Number.number(digits: 3) }
  end
end
