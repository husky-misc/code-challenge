require 'rails_helper'

RSpec.describe 'Transactions', type: :request do
  before do
    create(:transaction)
  end

  describe 'GET /customers/:customer_id/credit_cards/:credit_card_id/transactions' do
    context 'when it has invalid params' do
      it 'should return error' do
        get '/api/v1/customers/5/credit_cards/1/transactions'

        expect(response.status).to eq 400
      end
    end

    context 'when it has valid params' do
      it 'should return successfuly' do
        get '/api/v1/customers/2/credit_cards/1/transactions'

        expect(response.status).to eq 200
      end
    end
  end

  describe 'PUT /customers/:customer_id/credit_cards/:credit_card_id/transactions/:transaction_id/to_dispute' do
    context 'when it has invalid params' do
      it 'should return an error' do
        put '/api/v1/customers/5/credit_cards/1/transactions/1/to_dispute'

        expect(response.status).to eq 400
      end
    end

    context 'when transaction failed' do
      it 'should return an error about failed case' do
        transaction = Transaction.last
        transaction.update_attribute(:status, 'failed')

        put '/api/v1/customers/2/credit_cards/1/transactions/1/to_dispute'
        result = JSON.parse response.body

        expect(result['error']).to eq('This transaction failed')
      end
    end

    context 'when transaction is in dispute' do
      it 'should return an error about dispute case' do
        put '/api/v1/customers/2/credit_cards/1/transactions/1/to_dispute'
        result = JSON.parse response.body

        expect(result['error']).to eq('This transaction is already in dispute')
      end
    end

    context 'transaction refunded' do
      it 'should return an error about refund case' do
        transaction = Transaction.last
        transaction.update_attribute(:status, 'refunded')

        put '/api/v1/customers/2/credit_cards/1/transactions/1/to_dispute'
        result = JSON.parse response.body

        expect(result['error']).to eq('This transaction refunded')
      end
    end

    context 'when transaction paid' do
      it 'should change the transaction to dispute' do
        transaction = Transaction.last
        transaction.update_attribute(:status, 'paid')

        put '/api/v1/customers/2/credit_cards/1/transactions/1/to_dispute'

        expect(response.status).to eq 200
      end
    end
  end

  describe 'PUT /customers/5/credit_cards/1/transactions/1/refund' do
    context 'when it has invalid parameters' do
      it 'should return an error' do
        put '/api/v1/customers/5/credit_cards/1/transactions/1/refund'

        expect(response.status).to eq 400
      end
    end

    context 'when transaction is not in dispute' do
      it 'should return a warning error' do
        transaction = Transaction.last
        transaction.update_attribute(:status, 'failed')

        put '/api/v1/customers/2/credit_cards/1/transactions/1/refund'
        result = JSON.parse response.body

        expect(result['error']).to eq('The transaction must be in dispute to refund')
      end
    end

    context 'when transaction is in disute' do
      it 'should refund the transaction' do
        put '/api/v1/customers/2/credit_cards/1/transactions/1/refund'

        expect(response.status).to eq 200
      end
    end
  end
end
