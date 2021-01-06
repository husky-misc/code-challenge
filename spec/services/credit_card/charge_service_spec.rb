require 'rails_helper'

RSpec.describe CreditCard::ChargeService do
  subject(:service) { described_class.new(credit_card, amount: transaction_amount, currency: 'usd') }

  let(:credit_card) { create(:credit_card, spent_limit: 500_00) }
  let(:transaction_amount) { 500_00 }
  let(:transaction) { service.credit_card_transaction }

  describe '#call' do
    subject(:service_call) { service.call }

    context 'when the credit card have available limit' do
      it { is_expected.to be true }

      it 'creates a paid transaction' do
        expect { service_call }.to change(credit_card.transactions, :count).from(0).to(1)

        expect(transaction).to have_attributes(
          amount: transaction_amount,
          currency: 'usd',
          status: 'paid'
        )
      end

      it 'charges the credit card' do
        expect { service_call }.to change(credit_card, :spent_limit).from(500_00).to(0)
      end
    end

    context "when the credit card doesn't have available limit" do
      let(:transaction_amount) { 500_01 }

      it { is_expected.to be true }

      it 'creates a failed transaction' do
        service_call
        expect(transaction).to have_attributes(status: 'failed')
      end

      it 'does not charge the credit card' do
        expect { service_call }.not_to change(credit_card, :spent_limit)
      end
    end

    context 'with invalid params' do
      before { allow(credit_card).to receive(:update!).and_raise(ActiveRecord::RecordInvalid) }

      it { expect(service_call).to be_nil }

      it 'rollbacks the transaction' do
        expect { service_call }.not_to change(credit_card.transactions, :count)
      end
    end
  end
end
