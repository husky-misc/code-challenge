require 'rails_helper'

RSpec.describe 'Matches', type: :request do
  describe 'GET /index' do
    before do
      create(:play)
    end

    it 'returns http success' do
      get matches_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_match_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /show' do
    let(:play)  { create(:play) }
    let(:match) { play.match }

    it 'returns http success' do
      get match_path(match)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /create' do
    let(:file_path) { Rails.root.join('spec', 'support', 'complete_match_log') }
    let(:file)      { fixture_file_upload(file_path, 'log') }

    it 'returns http success' do
      post matches_path, params: { log: file }
      expect(response).to have_http_status(:found)
    end
  end
end
