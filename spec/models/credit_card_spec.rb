require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  context 'When is missing an attribute' do
    it 'should not save - missing customer_full_name' do
      credit_card = build(:credit_card, customer_full_name: nil)
      credit_card.save

      expect(credit_card.errors.full_messages.first).to eq("Customer full name can\'t be blank")
    end

    it 'should not save - missing number' do
      credit_card = build(:credit_card, number: nil)
      credit_card.save

      expect(credit_card.errors.full_messages.first).to eq("Number can\'t be blank")
    end

    it 'should not save - missing spent_limit' do
      credit_card = build(:credit_card, spent_limit: nil)
      credit_card.save

      expect(credit_card.errors.full_messages.first).to eq("Spent limit can\'t be blank")
    end
  end
end
