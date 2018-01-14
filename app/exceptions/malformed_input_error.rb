module Exceptions
  class MalformedInputError < StandardError
    def initialize(message='Malformed input.')
      super(message)
    end
  end
end