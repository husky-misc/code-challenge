FactoryBot.define do
  factory :credit_card do
    account_id { create(:account).id }
    number { Faker::Number.number(digits: 16) }
    cvv { rand(100..999) }
    expiration_date { (Time.now + rand(80000000..200000000)).strftime('%m/%y') }
    customer_full_name { Faker::Name.name }
    spent_limit { rand(100000..1000000) }
    flag { %w[Visa MasterCard].sample }
  end
end
