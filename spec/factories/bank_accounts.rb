FactoryBot.define do
  factory :bank_account do

    trait :with_transactions do
        transient do
          transactions_qt { 5 }
        end

        after(:create) do |bank_account, evaluator|
          create_list(:transaction, evaluator.transactions_qt, bank_account: bank_account)
        end
    end
  end
end
