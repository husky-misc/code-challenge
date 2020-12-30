require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'has valid parameters' do
    transaction = create :transaction

    expect(transaction).to be_valid
  end

  it 'is not valid with empty parameters' do
    transaction = Transaction.new

    expect(transaction).not_to be_valid
  end

  it 'is not valid without a credit card' do
    transaction = build(:transaction, credit_card: nil)

    expect(transaction).not_to be_valid
  end

  it 'cant have negative amount' do
    transaction = build(:transaction, amount: -100)

    expect(transaction).not_to be_valid
  end
end
