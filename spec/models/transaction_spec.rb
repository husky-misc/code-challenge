# == Schema Information
#
# Table name: transactions
#
#  id             :bigint           not null, primary key
#  amount         :float            not null
#  currency       :string           not null
#  status         :integer          default("dispute"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  credit_card_id :bigint           not null
#
# Indexes
#
#  index_transactions_on_credit_card_id  (credit_card_id)
#
# Foreign Keys
#
#  fk_rails_...  (credit_card_id => credit_cards.id)
#
require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    it { should belong_to(:credit_card) }
    it { should delegate_method(:spent_limit).to(:credit_card) }
  end
  
  describe 'validations' do
    [:amount, :currency, :status].each { |attribute| it { should validate_presence_of(attribute) } }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(dispute: 0, paid: 1, failed: 2, refunded: 3) }
  end

  describe 'scopes' do
    let(:credit_card) { create(:credit_card) }
    let!(:transactions) { create_list(:transaction, 10) }

    context ':status' do
      it 'filters the transactions by status, returns a json with only the transactions with the given status' do      
        expect(Transaction.status(1)).to all( have_attributes(status: 'paid') )
      end
    end
    
    before { create_list(:transaction, 5, credit_card_id: credit_card.id ) }

    context ':credit card' do  
      it 'filters the transactions by credit card, returns a json with only the transactions of the given credit card' do
        expect(Transaction.credit_card(credit_card)).to all( have_attributes(credit_card_id: credit_card.id) )
      end
    end
  end

  describe 'state machine rules' do
    context 'when the status is dispute' do
      let(:transactions) { build_list(:transaction, 4, status: :dispute) }

      it 'can be changed to paid and returns true' do
        expect(transactions.first.pay).to be(true)
      end

      it 'can be changed to refund and returns true' do
        expect(transactions.second.refund).to be(true)
      end
      
      it 'can be changed to failed and returns true' do
        expect(transactions.third.fail).to be(true)
      end

      it 'if the spent limit is greater then the amount, when the state is checked it decreases the amount available on the spent limit' do
        transaction = create(:transaction, status: :dispute)
        spent_limit_before_decrease = transaction.spent_limit
        transaction.check_state

        expect(spent_limit_before_decrease).to eq(transaction.spent_limit + transaction.amount)
      end

      it 'if the spent limit is smaller then the amount, when the state is check and it fails, the spent limit is not decreased' do
        credit_card = create(:credit_card)
        spent_limit_before_decrease = credit_card.spent_limit
        transaction = create(:transaction, credit_card_id: credit_card.id, amount: spent_limit_before_decrease + 1, status: :dispute)
        transaction.check_state

        expect(spent_limit_before_decrease).not_to eq(transaction.spent_limit + transaction.amount)
      end
    end

    context 'when the status is paid' do
      let(:transaction) { build(:transaction, status: :paid) }

      it 'can only be changed to dispute and returns true' do
        expect(transaction.dispute).to be(true)
      end

      it 'if you try to change the state to anything else, it raises an error' do
        expect { transaction.fail }.to raise_error(AASM::InvalidTransition)
      end
    end

    context 'when the status is failed' do
      let(:transaction) { build(:transaction, status: :failed) }

      it 'cannot be changed, it raises an error' do
        expect { transaction.dispute }.to raise_error(AASM::InvalidTransition)
      end
    end

    context 'when the status is refunded' do
      let(:transaction) { build(:transaction, status: :refunded) }

      it 'cannot be changed, it raises an error' do
        expect { transaction.dispute }.to raise_error(AASM::InvalidTransition)
      end
    end
  end
end
