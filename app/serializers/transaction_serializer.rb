# frozen_string_literal: true

class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attribute :operation_type

  attribute :value do |object|
    object.display_value
  end
end
