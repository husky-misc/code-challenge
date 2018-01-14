module Support
  module JsonHelper
    def json
      JSON.parse(response.body)
    end
  end
end