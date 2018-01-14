require 'rails_helper'

describe Api::V1::IpController, type: :controller do
  before {
    request.content_type = 'application/json; charset=utf-8'
  }

  describe 'POST /api/v1/store' do
    context 'when data is valid' do
      let!(:ip) do
        {
          'ip_list': [
            '1.1.1.1: 1,2,3'
          ]
        }.as_json
      end
      it 'should be stored' do
        post :store, params: ip, format: :json
        
        expect(Ip.all.count).to eq(1)
        expect(response).to have_http_status(:ok)
      end
    end
    context 'when data is invalid' do
      let!(:ip) do
        {
          'ip_list': [
            '1.1.1: 1,2,3'
          ]
        }.as_json
      end
      it 'should raise InputMalformedError' do
        post :store, params: ip, format: :json
        
        expect(Ip.all.count).to eq(0)
        expect(response).to have_http_status(:bad_request)
        expect(json['error']).to eq('Malformed input.')
      end
    end
  end
  
  describe '/api/v1/compute' do
    context 'when it has ips stored' do
      let!(:ip)      { create(:ip) }
      let!(:ip2)     { create(:ip, values: [1, 5]) }
      let(:expected) { 
          {
            data: {
              ip_code: {
                ip.address => '1,2,3,5'
              }
            }
          }.as_json
       }

      it 'should return computed data' do
        post :compute
        expect(ComputeHistory.all.count).to eq(1)
        expect(Ip.all.count).to eq(0)
        expect(json).to eq(expected)
      end
    end

    context 'when it has no ips stored' do
      let(:expected) {
        {
          data: {
            ip_code: {}
          }
        }.as_json
      }
      
      it 'should return empty ip_code' do
        post :compute

        expect(ComputeHistory.all.count).to eq(1)
        expect(json).to eq(expected)
      end
    end
  end

  describe '/api/v1/compute_histories' do
    context 'when requested' do
      let!(:history)  { create(:compute_history) }
      let!(:expected) {
        {
          data: [
            {
              ip_code: { 
                '1.1.1.1' => '1,2,3'
               },
               computed_at: history.computed_at
            }
          ]
        }.as_json
      }

      it 'should return all previous computed data' do
        get :compute_histories
        expect(json).to eq(expected)
      end
    end
  end
end
