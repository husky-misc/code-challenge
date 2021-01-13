FactoryBot.define do
  factory :credit_card do
    account { nil }
    spent_limit { 1 }
    number { "MyString" }
    expiration_date { "2021-01-13" }
    cvv { "MyString" }
    full_name { "MyString" }
  end
end
