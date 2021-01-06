FactoryBot.define do
  factory :credit_card do
    association :account, strategy: :create
    spent_limit { 10_000_00 }
    number { Faker::Finance.credit_card(:mastercard, :visa).delete('-') }
    expiration_date { '0125' }
    cvv { Faker::Number.number(digits: rand(3..4)) }
    customer_full_name { Faker::Name.name }
  end
end
