RSpec.shared_examples 'http status code' do |status|
  it "returns status code #{status}" do
    expect(response).to have_http_status(status)
  end
end