require 'rails_helper'

RSpec.describe ::Api::V1::RankingsController, type: :controller do
  describe '.create' do
    context 'when a valid uploaded log file is provided' do
      setup do
        post :create, params: { log_id: create(:log).id }
      end

      it { expect(response).to have_http_status(:created) }
      it { expect(response.body).to be_present }
    end

    context 'when an invalid file is provided' do
      setup do
        post :create, params: { log_id: create(:invalid_log).id }
      end

      it { expect(response).to have_http_status(:bad_request) }
    end
  end
end
