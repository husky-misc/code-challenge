FactoryBot.define do
  factory :transaction do
    association(:chargeable, factory: :credit_card)
    status { :pending }
    amount { rand(1..100_000) }
    currency { 'BRL' }
  end
end
