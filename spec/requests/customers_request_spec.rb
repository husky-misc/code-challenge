require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe 'GET /customers/:customer_id/credit_cards/:credit_card_id/transactions' do
    let(:credit_card) { create(:credit_card) }
    let!(:transactions) { create_list(:transaction, 10, credit_card_id: credit_card.id) }
    let(:customer_id) { credit_card.account.customer.id }
    let(:credit_card_id) { credit_card.id }

    before { get "/customers/#{customer_id}/credit_cards/#{credit_card_id}/transactions" }

    context 'when user exists' do
      context 'when the credit card exists' do
        it 'returns the transactions' do
          expect(json['transactions']).to all( include("credit_card_id" => credit_card.id) )
        end
      end

      context 'when the credit card does not exist' do
        let(:credit_card_id) { 0 }

        it 'returns an error message' do
          expect(json['message']).to match(/Couldn't find CreditCard/)
        end
      end
    end

    context 'when user does not exist' do
      let(:customer_id) { 0 }

      it 'returns an error message' do
        expect(json['message']).to match(/Couldn't find Customer/)
      end
    end
  end
end
