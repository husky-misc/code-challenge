FactoryBot.define do
  factory :bank_account do

    trait :with_transactions do
        transient do
          length { 5 }
        end

        after(:create) do |bank_account, evaluator|
          create_list(:transaction, evaluator.length, bank_account: bank_account)
        end
    end
  end
end
