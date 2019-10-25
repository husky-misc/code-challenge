FactoryBot.define do
  factory :transaction do
    account
    operation_type { 'credit' }
    value { 42.0 }
  end
end
