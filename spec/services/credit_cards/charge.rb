require 'rails_helper'

describe ::CreditCards::Charge, :service do
  describe '.call' do
    subject { described_class.new(credit_card: credit_card, amount: amount, currency: 'whatever') }
    let(:customer) { create(:customer, :with_account) }
    let(:credit_card) { create(:credit_card, account: customer.account, spent_limit: 10_000_00) }

    context 'with a possible charge' do
      let(:amount) { 5_000_00 }

      it { expect(subject.call).to be_truthy }
      it { expect { subject.call }.to change(::Transaction, :count).by(1) }
      it 'create an successful transaction' do
        subject.call
        expect(Transaction.last.status).to eq('paid')
      end
    end

    context 'with insufficient limit' do
      let(:amount) { 99_999_99 }

      it { expect(subject.call).to be_falsey }
      it 'create an successful transaction' do
        subject.call
        expect(Transaction.last.status).to eq('failed')
      end
    end
  end
end
