class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { message: e.message }, status: :unprocessable_entity
  end

  protected

  def cache_active_record_collection_block(record:, query:, expiration: 12.hours)
    key = "#{record.cache_key_with_version}_#{query}"
    cached_block = Rails.cache.read(key)
    return cached_block unless cached_block.nil?
    cached_block = yield.to_a
    Rails.cache.write(key, cached_block, expires_in: expiration)
    return cached_block
  end
end
