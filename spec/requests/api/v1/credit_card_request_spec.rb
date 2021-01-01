require 'rails_helper'

RSpec.describe "Api::V1::CreditCards", type: :request do
  context 'success' do
    before do
      headers = { "ACCEPT" => "application/json" }
      params = { currency: 'usd', amount: 1000 }

      post 'https://localhost:3000/api/v1/customers/1/credit_cards/1/charge', headers: headers, params: params
    end

    it 'has status 201' do
      expect(response).to have_http_status :created
    end

    it 'is json' do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  context 'with negative amount' do
    before do
      headers = { "ACCEPT" => "application/json" }
      params = { currency: 'usd', amount: -1000 }

      post 'https://localhost:3000/api/v1/customers/1/credit_cards/1/charge', headers: headers, params: params
    end

    it 'has status 400' do
      expect(response).to have_http_status :bad_request
    end
  end
end
