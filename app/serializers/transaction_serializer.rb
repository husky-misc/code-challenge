class TransactionSerializer < ActiveModel::Serializer
  attributes :id,
             :description,
             :transaction_type,
             :amount,
             :balance,
             :previous_balance,
             :created_at
end
