# frozen_string_literal: true

require 'test_helper'
require 'caching'

module Caching
  class WarmCacheTest < ActiveSupport::TestCase
    include CachingHelper

    test '.warm_cache! creates the cache for all possible parameters' do
      WarmCacheResourceArray = Class.new do
        include CacheableResource

        cache_options default_cache_warm_with: [[1, 2], [3, 4]]

        def initialize(first_value, second_value)
          @first_value  = first_value
          @second_value = second_value
        end

        def id
          42
        end

        def heavy_method
          [@first_value, @second_value]
        end
        cache :heavy_method
      end

      with_caching do
        WarmCacheResourceArray.expects(:new).with(1, 3).once.then.returns(mocked_instances[0])
        WarmCacheResourceArray.expects(:new).with(1, 4).once.then.returns(mocked_instances[1])
        WarmCacheResourceArray.expects(:new).with(2, 3).once.then.returns(mocked_instances[2])
        WarmCacheResourceArray.expects(:new).with(2, 4).once.then.returns(mocked_instances[3])

        WarmCacheResourceArray.warm_cache!
      end
    end

    test '.warm_cache! creates the cache for all possible parameters that responds too call' do
      WarmCacheResourceArray = Class.new do
        include CacheableResource

        cache_options default_cache_warm_with: [-> { [1, 2] }, -> { [3, 4] }]

        def initialize(first_value, second_value)
          @first_value  = first_value
          @second_value = second_value
        end

        def id
          42
        end

        def heavy_method
          [@first_value, @second_value]
        end
        cache :heavy_method
      end

      with_caching do
        WarmCacheResourceArray.expects(:new).with(1, 3).once.then.returns(mocked_instances[0])
        WarmCacheResourceArray.expects(:new).with(1, 4).once.then.returns(mocked_instances[1])
        WarmCacheResourceArray.expects(:new).with(2, 3).once.then.returns(mocked_instances[2])
        WarmCacheResourceArray.expects(:new).with(2, 4).once.then.returns(mocked_instances[3])

        WarmCacheResourceArray.warm_cache!
      end
    end

    test '.warm_cache! works with named arguments' do
      WarmCacheResourceWithNamedArgs = Class.new do
        include CacheableResource

        cache_options default_cache_warm_with: { first_arg: -> { [1, 2] }, second_arg: -> { [3, 4] } }

        def initialize(first_arg:, second_arg:)
          @first_value  = first_arg
          @second_value = second_arg
        end

        def id
          42
        end

        def heavy_method
          [@first_value, @second_value]
        end
        cache :heavy_method
      end

      with_caching do
        WarmCacheResourceWithNamedArgs.expects(:new).with(first_arg: 1, second_arg: 3).once.then.returns(mocked_instances[0])
        WarmCacheResourceWithNamedArgs.expects(:new).with(first_arg: 1, second_arg: 4).once.then.returns(mocked_instances[1])
        WarmCacheResourceWithNamedArgs.expects(:new).with(first_arg: 2, second_arg: 3).once.then.returns(mocked_instances[2])
        WarmCacheResourceWithNamedArgs.expects(:new).with(first_arg: 2, second_arg: 4).once.then.returns(mocked_instances[3])

        WarmCacheResourceWithNamedArgs.warm_cache!
      end
    end

    private

    def mocked_instances
      @instances ||= prepare_mocked_instances
    end

    def prepare_mocked_instances
      first_instance  = stub
      second_instance = stub
      third_instance  = stub
      fourth_instance = stub
      first_instance.expects(:heavy_method).once
      second_instance.expects(:heavy_method).once
      third_instance.expects(:heavy_method).once
      fourth_instance.expects(:heavy_method).once
      [first_instance, second_instance, third_instance, fourth_instance]
    end
  end
end
