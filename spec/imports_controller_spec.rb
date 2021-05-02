require "rails_helper"

RSpec.describe "Import", type: :request do
  @valid_data = <<LOG
  23/04/2013 15:34:22 - New match 11348965 has started
  23/04/2013 15:36:04 - Roman killed Nick using M16
  23/04/2013 15:36:33 - <WORLD> killed Nick by DROWN
  23/04/2013 15:39:22 - Match 11348965 has ended
LOG

  @invalid_data = <<LOG
    23/04/2013 15:34:22 - New competition 11348965 has initialized
    23/04/2013 15:36:04 - Roman murdered Nick using M16
    23/04/2013 15:36:33 - <WORLD> murdered Nick by DROWN
    23/04/2013 15:39:22 - Match 11348965 has ended
LOG

  describe 'import game log' do
    it 'returns created when it succeed' do
      headers = {"ACCEPT" => "application/json"}
      post "/import", params: { log: @valid_data }, headers: headers

      expect(response).to have_http_status(:created)
    end

    xit 'returns bad request when invalid data is provided' do
      headers = {"ACCEPT" => "application/json"}
      post "/import", params: { log: @invalid_data }, headers: headers

      expect(response).to have_http_status(:bad_request)
    end
  end
end
