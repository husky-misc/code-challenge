# frozen_string_literal: true

# this definitily should be refactored!
module Caching
  module WarmCache
    class InstanceArgument
      def self.fetch_argument(argument)
        argument.respond_to?(:call) ? argument.call : argument
      end

      # a lot of repeated code.. should be refactored and maybe two classes should be created. a HashInstanceArgument and ArrayInstanceArgument, and this one
      # should be act as a builder.
      def self.generate(options)
        if options.is_a?(Hash)
          keys = options.keys
          first_argument = fetch_argument(options[keys[0]])
          rest_arguments = keys[1..-1].map { |key| fetch_argument(options[key]) }

          product = first_argument.product(*rest_arguments)
          product.map do |values|
            args = {}
            values.each_with_index { |value, index| args[keys[index]] = value }
            args
          end
        else
          first_argument = fetch_argument(options[0])
          rest_arguments = options[1..-1].map { |option| fetch_argument(option) }
          first_argument.product(*rest_arguments)
        end
      end
    end

    def warm_cache!
      warm_options = __cache_options[:default_cache_warm_with]
      return unless warm_options

      instances_arguments = InstanceArgument.generate(warm_options)
      execute_warm_for(instances_arguments)
    end

    private

    def execute_warm_for(instances_arguments)
      instances = instances_arguments.map { |arguments| arguments.is_a?(Hash) ? self.new(**arguments) : self.new(*arguments) }
      __cached_methods.each do |method|
        instances.each do |instance|
          instance.public_send(method.to_sym)
        end
      end
    end
  end
end
