require 'rails_helper'

RSpec.describe 'Api::V1::Transactions', type: :request do
  before do
    transaction = create :transaction
    transaction.pay!
  end

  context 'success' do
    before do
      headers = { "ACCEPT" => "application/json" }
      get 'https://localhost:3000/api/v1/customers/1/credit_cards/1/transactions', headers: headers
    end

    it 'has status 200' do
      expect(response).to have_http_status :ok
    end

    it 'is json' do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  context 'with wrong status' do
    before do
      headers = { "ACCEPT" => "application/json" }
      get 'https://localhost:3000/api/v1/customers/1/credit_cards/1/transactions?status=random_status', headers: headers
    end

    it 'has status 404' do
      expect(response).to have_http_status :not_found
    end
  end

  context 'with right status' do
    before do
      headers = { "ACCEPT" => "application/json" }
      get 'https://localhost:3000/api/v1/customers/1/credit_cards/1/transactions?status=failed', headers: headers
    end

    it 'has status 200' do
      expect(response).to have_http_status :ok
    end
  end
end
