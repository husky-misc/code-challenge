FactoryBot.define do
  factory :transaction do
    description { Faker::Currency.name }
    amount { Faker::Number.decimal(l_digits: 3, r_digits: 3) }

    # fks
    bank_account

    trait :type_credit do
      transaction_type { 0 }
    end

    trait :type_debit do
      transaction_type { 1 }
    end
  end
end
