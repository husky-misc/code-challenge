require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  describe 'Factory' do
    context 'When create bank_account Factory' do
      it 'should create without error' do
        2.times do
          expect(create(:bank_account)).to be_truthy
        end
      end

      it 'should have default current_balance equal 0' do
        expect(create(:bank_account).current_balance).to eq 0
      end

      it 'should have default_currency equal BRL' do
        expect(create(:bank_account).default_currency).to eq 'BRL'
      end
    end

    context 'When create :with_transactions' do
      let(:bank_account) { create(:bank_account, :with_transactions) }

      it 'should create without error' do
        expect(bank_account).to be_truthy
      end

      it 'should have transactions' do
        expect(bank_account.transactions.size > 1).to be_truthy
      end
    end
  end
end
