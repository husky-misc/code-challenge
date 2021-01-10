require 'rails_helper'

RSpec.describe CreditCard, type: :request do
  before do
    create(:credit_card)
    @customer_id = Customer.last.id
    @credit_card_id = CreditCard.last.id
  end

  describe 'POST /customers/:customer_id/credit_cards/:credit_card_id/charge' do
    context 'when transaction amount is less than spent limit' do
      it 'should create a paid transaction' do
        post "/api/v1/customers/#{@customer_id}/credit_cards/#{@credit_card_id}/charge", params: {
          transaction: {
            currency: 'usd',
            amount: '10000'
          }
        }

        transaction = Transaction.last
        expect(transaction.status).to eq('paid')
      end
    end

    context 'when transaction amount is greater than spent limit' do
      it 'should create a failed transaction' do
        post "/api/v1/customers/#{@customer_id}/credit_cards/#{@credit_card_id}/charge", params: {
          transaction: {
            currency: 'usd',
            amount: '1100000'
          }
        }

        transaction = Transaction.last
        expect(transaction.status).to eq('failed')
      end
    end
  end
end
