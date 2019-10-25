# frozen_string_literal: true

require 'test_helper'
require 'caching'

module Caching
  class CacheableResourceTest < ActiveSupport::TestCase
    include CachingHelper

    test '.cache caches the method' do
      DummyResourceCache = Class.new do
        include CacheableResource

        def id
          42
        end

        def heavy_method(dependency)
          dependency.heavy_method
        end
        cache :heavy_method
      end

      resource = DummyResourceCache.new

      with_caching do
        dependency = stub

        dependency.stubs(:heavy_method).once

        resource.heavy_method(dependency)
        resource.heavy_method(dependency)
      end
    end

    test '.invalidate_cache_for removes the used cache' do
      DummyResourceInvalidate = Class.new do
        include CacheableResource

        def id
          42
        end

        def heavy_method(dependency)
          dependency.heavy_method
        end
        cache :heavy_method
      end

      resource = DummyResourceInvalidate.new

      with_caching do
        dependency = stub

        dependency.stubs(:heavy_method).twice

        resource.heavy_method(dependency)
        DummyResourceInvalidate.invalidate_cache_for(42)
        resource.heavy_method(dependency)
      end
    end

    test '#cache_key without custom cache keys returns with the id' do
      DummyResourceWithId = Class.new do
        include CacheableResource

        def id
          42
        end
      end

      resource = DummyResourceWithId.new

      assert_equal 'DummyResourceWithId/42', resource.cache_key
    end

    test '#cache_key with custom cache keys uses them instead of the id' do
      DummyResourceWithCustomKeys = Class.new do
        include CacheableResource

        def id
          42
        end

        def custom_cache_keys
          ['custom_id', 'custom_arg']
        end
      end

      resource = DummyResourceWithCustomKeys.new

      assert_equal 'DummyResourceWithCustomKeys/custom_id/custom_arg', resource.cache_key
    end

    test '#cache_key raises error if it is not possible to generate' do
      DummyResourceInvalid = Class.new do
        include CacheableResource
      end

      resource = DummyResourceInvalid.new

      assert_raise ArgumentError do
        resource.cache_key
      end
    end
  end
end
