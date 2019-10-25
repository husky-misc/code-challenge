# frozen_string_literal: true

require 'caching/warm_cache'

module Caching
  module CacheableResource
    module ClassMethods
      @@_mutex          = Mutex.new
      @@_cache_options  = {}
      @@_cached_methods = []

      def cache_options(options={})
        @@_mutex.synchronize do
          @@_cache_options.merge!(options)
        end
      end

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
          add_method_to_cached_list(method)
          define_method method do |*args|
            Rails.cache.fetch("#{cache_key}/#{method}") do
              public_send("#{method}_without_cache", *args)
            end
          end
        end
      end

      private

      def add_method_to_cached_list(method)
        @@_mutex.synchronize do
          @@_cached_methods << method
        end
      end

      def __cache_options
        @@_cache_options
      end

      def __cached_methods
        @@_cached_methods
      end
    end

    def self.included(klass)
      klass.extend(ClassMethods)
      klass.extend(WarmCache)
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
