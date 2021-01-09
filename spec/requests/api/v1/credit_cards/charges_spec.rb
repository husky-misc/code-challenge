require 'rails_helper'

RSpec.describe ::Api::V1::CreditCards::ChargesController, type: :request do
  describe 'POST /api/v1/customers/:customer_id/credit_cards/:credit_card_id/charge' do
    before do
      post "/api/v1/customers/#{customer[:id]}/credit_cards/#{credit_card[:id]}/charge", params: params
    end

    context 'with invalid customer' do
      let(:customer) { { id: 999 } }
      let(:credit_card) { { id: 999 } }
      let(:params) {}

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'with invalid customer and credit card' do
      let(:customer) { create(:customer, :with_account) }
      let(:credit_card) { { id: 999 } }
      let(:params) {}

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'with invalid charge params' do
      let(:customer) { create(:customer, :with_account) }
      let(:credit_card) { create(:credit_card, account: customer.account) }
      let(:params) {}

      it { expect(response).to have_http_status(:bad_request)}
    end

    context 'with valid params' do
      let(:params) { { amount: 5_000_00, currency: 'USD' } }
      let(:customer) { create(:customer, :with_account) }
      let(:hash_body) { JSON.parse(response.body) }

      context 'with insufficient limit' do
        let(:credit_card) { create(:credit_card, account: customer.account, spent_limit: 3_000_00) }
        it { expect(response.content_type).to match('application/json') }
        it { expect(response).to have_http_status(:not_acceptable) }
        it { expect(hash_body["error"]).to eq("Insufficient Limit") }

      end

      context 'with limit' do
        let(:credit_card) { create(:credit_card, account: customer.account, spent_limit: 10_000_00) }
        it { expect(response).to have_http_status(:created) }
      end
    end
  end
end
