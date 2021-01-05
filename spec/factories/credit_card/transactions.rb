FactoryBot.define do
  factory :credit_card_transaction, class: 'CreditCard::Transaction' do
    CreditCard::Transaction.aasm.state_machine.config.no_direct_assignment = false

    credit_card
    amount { 1_000_00 }
    currency { 'usd' }

    trait :paid do
      status { :paid }
    end

    trait :dispute do
      status { :dispute }
    end
  end
end
