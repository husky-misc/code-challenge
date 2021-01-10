require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'is invalid when is missing amount' do
    transaction = build(:transaction, amount: nil)
    transaction.save

    expect(transaction.errors.full_messages.first).to eq("Amount can\'t be blank")
  end

  it 'is invalid when is missing currency' do
    transaction = build(:transaction, currency: nil)
    transaction.save

    expect(transaction.errors.full_messages.first).to eq("Currency can\'t be blank")
  end

  it 'is valid with both amount and currency' do
    transaction = build(:transaction)

    expect(transaction.save).to eq true
  end
end
