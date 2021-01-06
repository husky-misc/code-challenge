require 'rails_helper'

RSpec.describe "Api::V1::Transactions", type: :request do
  describe 'index' do
    let(:credit_card) { create(:credit_card) }
    let(:customer) { credit_card.customer }
    let(:path) { "/api/v1/customer/#{customer.id}/credit_card/#{credit_card.id}/transactions" }
    let(:paid_transaction) { create(:credit_card_transaction, :paid, credit_card: credit_card) }
    let(:dispute_transaction) { create(:credit_card_transaction, :dispute, credit_card: credit_card) }

    it 'paginates the result' do
      allow(CreditCard::Transaction).to receive(:default_per_page).and_return(1)

      paid_transaction
      dispute_transaction

      get path
      expect(json_body).to contain_exactly(hash_including('id' => paid_transaction.id))

      get "#{path}?page=2"
      expect(json_body).to contain_exactly(hash_including('id' => dispute_transaction.id))
    end

    context 'with a valid status query' do
      it 'returns transactions with given status' do
        paid_transaction
        dispute_transaction

        get "#{path}?status=paid"
        expect(json_body).to contain_exactly(hash_including('id' => paid_transaction.id))
      end
    end

    context 'with an invalid status query' do
      it 'returns an error' do
        get "#{path}?status=dummystatus"

        expect(response).to have_http_status(:bad_request)
        expect(json_body).to eq('error' => 'Invalid status')
      end
    end
  end
end
