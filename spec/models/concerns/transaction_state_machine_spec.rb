require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:credit_card) { create(:credit_card, spent_limit: 100_00) }

  context 'from started' do
    context '.pay!' do
      context 'to paid' do
        subject(:transaction) do
          build(:transaction, credit_card: credit_card, amount: 10_00)
        end

        before { transaction.pay! }

        it 'has status paid' do
          expect(transaction.paid?).to be_truthy
        end

        it 'withdraws from credit card' do
          expect(credit_card.spent_limit).to eq 90_00
        end
      end

      context 'to failed' do
        subject(:transaction) do
          build(:transaction, credit_card: credit_card, amount: 500_00)
        end

        before { transaction.pay! }

        it 'has status failed' do
          expect(transaction.failed?).to be_truthy
        end

        it 'dont withdraw from credit card' do
          expect(credit_card.spent_limit).to eq 100_00
        end
      end
    end

    context '.dispute! and .refund!' do
      subject(:transaction) do
        build(:transaction, credit_card: credit_card, amount: 10_00)
      end

      it 'should not trigger' do
        expect(transaction.dispute!).to be_falsey
      end

      it 'should not trigger' do
        expect(transaction.refund!).to be_falsey
      end
    end
  end

  context 'from paid' do
    context 'to dispute' do
      subject(:transaction) do
        build(:transaction, credit_card: credit_card, amount: 10_00)
      end

      before do
        transaction.pay!
        transaction.dispute!
      end

      it 'has status disputed' do
        expect(transaction.dispute?).to be_truthy
      end

      it 'returns to paid after dispute again' do
        transaction.dispute!

        expect(transaction.paid?).to be_truthy
      end
    end
  end

  context 'from dispute' do
    context 'to paid' do
      subject(:transaction) do
        build(:transaction, credit_card: credit_card, amount: 10_00)
      end

      before do
        transaction.pay!
        transaction.dispute!
        transaction.dispute!
      end

      it 'has status disputed' do
        expect(transaction.paid?).to be_truthy
      end

      it 'has limit withdrawed from credit card' do
        expect(credit_card.spent_limit).to eq 90_00
      end
    end

    context 'to refunded' do
      subject(:transaction) do
        build(:transaction, credit_card: credit_card, amount: 10_00)
      end

      context '.refund!' do
        before do
          transaction.pay!
          transaction.dispute!
          transaction.refund!
        end

        it 'has status refunded' do
          expect(transaction.refunded?).to be_truthy
        end

        it 'returns limit withdrawed from credit card' do
          expect(credit_card.spent_limit).to eq 100_00
        end
      end

      context 'cant be refunded without being in dispute' do
        subject(:transaction) do
          build(:transaction, credit_card: credit_card, amount: 10_00)
        end

        it { expect(transaction.refund!).to be_falsey }
        it { expect(transaction.dispute!).to be_falsey }
      end
    end
  end
end
