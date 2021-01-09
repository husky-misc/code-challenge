require 'rails_helper'

RSpec.describe ::Api::V1::TransactionsController, type: :request do
  describe 'GET /api/v1/customers/:customer_id/credit_cards/:credit_card_id/transactions' do
    before do
      get "/api/v1/customers/#{customer[:id]}/credit_cards/#{credit_card[:id]}/transactions"
    end

    context 'with invalid customer' do
      let(:customer) { { id: 999 } }
      let(:credit_card) { { id: 999} }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.content_type).to match('application/json') }
    end

    context 'with invalid customer and credit card' do
      let(:customer) { create(:customer, :with_account) }
      let(:credit_card) { { id: 999 } }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.content_type).to match('application/json') }
    end

    context 'with valid params' do
      before do
        create(:transaction, status: :paid, chargeable: credit_card)
        create(:transaction, status: :failed, chargeable: credit_card)
        create(:transaction, status: :disputed, chargeable: credit_card)
      end

      context 'with invalid status' do
        let(:customer) { create(:customer, :with_account) }
        let(:credit_card) { create(:credit_card, account: customer.account) }
        let(:hash_body) { JSON.parse(response.body) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(hash_body["data"]).to be_empty }
        it { expect(response.content_type).to match('application/json') }
      end

      context 'with valid status' do
        let(:customer) { create(:customer, :with_account) }
        let(:credit_card) { create(:credit_card, account: customer.account) }

        it { expect(response).to have_http_status(:ok) }
        it { expect(response.content_type).to match('application/json') }
      end
    end
  end
end
