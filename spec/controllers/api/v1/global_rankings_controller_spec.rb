require 'rails_helper'

RSpec.describe ::Api::V1::GlobalRankingsController, type: :controller do
  describe '.create' do
    context 'when generating the global ranking' do
      setup do
        create_list(:log, 5)
        post :create
      end

      it { expect(response).to have_http_status(:created) }
    end
  end
end
