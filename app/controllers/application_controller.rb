class ApplicationController < ActionController::API
  before_action :validate_request

  private

  def validate_request
    valid_content_type = /(?=.*application\/json;.)(?=.*charset=utf-8)/.match?(request.headers['Content-Type'])

    render json: { error: 'Unsupported Media Type' }, status: 415 unless valid_content_type
  end
end
