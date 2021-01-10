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

  context 'Business Rules' do
    it 'status cannot change from PAID to FAILED' do
      transaction = build(:transaction, status: 'paid')

      expect { transaction.fail }.to raise_error(AASM::InvalidTransition)
    end

    it 'status cannot change to REFUNDED unless from dispute' do
      transaction = build(:transaction, status: 'paid')

      expect { transaction.refund }.to raise_error(AASM::InvalidTransition)
    end

    it 'status can change from DISPUTE to PAID' do
      transaction = build(:transaction)

      expect(transaction.pay).to eq true
    end

    it 'status can change from DISPUTE to REFUNDED' do
      transaction = build(:transaction)

      expect(transaction.refund).to eq true
    end

    it 'status will change to FAILED if has not limit enough' do
      credit_card = create(:credit_card, spent_limit: 10000)
      transaction = create(:transaction, credit_card_id: credit_card.id)

      transaction.check_status
      expect(transaction.status).to eq('failed')
    end

    it 'status under disput do not decrease the spent limit' do
      credit_card = create(:credit_card, spent_limit: 10000)
      create(:transaction, credit_card_id: credit_card.id, amount: 5000)

      expect(credit_card.spent_limit).to eq(10000)
    end
  end
end
