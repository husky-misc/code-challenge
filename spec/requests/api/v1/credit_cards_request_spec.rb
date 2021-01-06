require 'rails_helper'

RSpec.describe "Api::V1::CreditCards", type: :request do
  describe 'charge' do
    let(:credit_card) { create(:credit_card, spent_limit: 1_000_00) }
    let(:customer) { credit_card.customer }
    let(:request_call) { post "/api/v1/customer/#{customer.id}/credit_card/#{credit_card.id}/charge", params: params }

    shared_examples 'returns a transaction' do |transaction_status|
      it do
        request_call

        expect(response).to have_http_status(:created)
        expect(json_body['status']).to eq(transaction_status.to_s)
      end
    end

    context 'with available amount' do
      let(:params) { { amount: '50000', currency: 'usd' } }

      it_behaves_like 'returns a transaction', :paid
    end

    context 'with unavailable amount' do
      let(:params) { { amount: '100001', currency: 'usd' } }

      it_behaves_like 'returns a transaction', :failed
    end

    context 'with invalid params' do
      let(:params) { { amount: 'a' } }

      it 'returns a error object' do
        request_call

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_body['error']).not_to be_nil
      end
    end
  end
end
