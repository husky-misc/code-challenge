class ApplicationController < ActionController::API
  before_action :validate_request

  private

  def validate_request
    valid_content_type = request.headers['Content-Type'].present? && /(?=.*application\/json;.)(?=.*charset=utf-8)/.match?(request.headers['Content-Type'].downcase)

    puts request.format
    puts request.headers['CONTENT_TYPE']
    return render json: { error: 'Unsupported Media Type' }, status: 415 unless valid_content_type
    return render json: { error: 'Unsupported Media Type' }, status: 415 unless ['*/*', 'application/json'].include?(request.format)
    return render json: { error: 'Unauthorized' },           status: 401 unless authenticated?
  end

  def authenticated?
    ApiKey.find_by(token: bearer_token)
    true
  rescue Mongoid::Errors::DocumentNotFound
    false
  end

  def bearer_token
    pattern = /^Bearer\s+/
    header  = request.headers["Authorization"]
    return nil if header.nil?

    header.gsub(pattern, '') if header && header.match(pattern)
  end
end
