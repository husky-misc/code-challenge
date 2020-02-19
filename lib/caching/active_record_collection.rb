module Caching
  module ActiveRecordCollection
    def cache_block(record:, query:, expiration: 12.hours)
      key = "#{record.cache_key_with_version}_#{query}"
      cached_block = Rails.cache.read(key)
      return cached_block unless cached_block.nil?
      cached_block = yield.to_a
      Rails.cache.write(key, cached_block, expires_in: expiration)
      return cached_block
    end
  end
end
