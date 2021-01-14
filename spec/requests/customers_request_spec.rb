require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe 'GET /customers/:id/credit_cards/:credit_card_id/transactions' do
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

  describe 'GET /customers/:id/credit_cards/:credit_card_id/charge' do
    let(:credit_card) { create(:credit_card) }
    let(:customer_id) { credit_card.account.customer.id }
    let(:credit_card_id) { credit_card.id }

    before { post "/customers/#{customer_id}/credit_cards/#{credit_card_id}/charge", params: { transaction: { amount: Faker::Number.within(range: 1..10000), currency: Faker::Currency.code } } }

    context 'when user exists' do
      context 'when credit card exists' do
        context 'when the params have the attributes' do
          it 'creates the transaction' do            
            expect(json['transaction']['credit_card_id']).to eq(credit_card.id)
          end
        end

        
        context 'when the params is missing the attributes' do
          before { post "/customers/#{customer_id}/credit_cards/#{credit_card_id}/charge", params: { transaction: { currency: Faker::Currency.code } } }

          it 'returns an error message' do
            expect(json).to match([/can't be blank/])
          end
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
