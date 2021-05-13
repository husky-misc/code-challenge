require 'rails_helper'

RSpec.describe ::Api::V1::LogsController, type: :controller do
  describe '.create' do
    context 'when a valid file is provided' do
      setup do
        post :create,
             params: {
               game_mode: :contra_squad,
               description: 'Some optional description...',
               file: fixture_file_upload("#{fixture_path}/files/matches_log.txt", 'text/plain')
             }
      end

      it { expect(::Log.last.file.filename.to_s).to eq('matches_log.txt') }
    end

    context 'when an invalid file is provided' do
      setup do
        post :create,
             params: { log: {
               game_mode: :contra_squad,
               description: 'Some optional description...',
               file: fixture_file_upload("#{fixture_path}/files/matches_log.jpg", 'image/jpg')
             } }
      end

      it { expect(response).to have_http_status(:bad_request) }
    end
  end
end
