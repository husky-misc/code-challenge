module Caching
  module CacheableResource
    module ClassMethods
      def class_name
        name.split('::').last
      end

      def invalidate_cache_for(*keys)
        pattern = keys.join('/')
        Rails.cache.delete_matched("#{class_name}/#{pattern}*")
      end

      def cache(method)
        class_eval do
          alias_method "#{method}_without_cache", method
          define_method method do |*args|
            Rails.cache.fetch("#{cache_key}/#{method}") do
              public_send("#{method}_without_cache", *args)
            end
          end
        end
      end
    end

    def self.included(klass)
      klass.extend(ClassMethods)
    end

    def cache_key
      raise ArgumentError.new('You must have id or custom_cache_keys method implemented in your class') unless self.respond_to?(:id) || self.respond_to?(:custom_cache_keys)

      keys = if self.respond_to?(:custom_cache_keys)
               self.custom_cache_keys
             else
               self.id
             end

      [self.class.class_name, keys].flatten.join('/')
    end
  end
end
