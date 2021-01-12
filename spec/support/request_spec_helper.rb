module RequestSpecHelper
  def json
    JSON.parse(response.body) if response.body
  end
end