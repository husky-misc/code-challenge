class TransactionSerializer < ActiveModel::Serializer
  attributes :id,
             :description,
             :transaction_type,
             :amount,
             :balance,          # TODO: Balance should be update using a Service called to create transactions
             :previous_balance, #
             :created_at
end
