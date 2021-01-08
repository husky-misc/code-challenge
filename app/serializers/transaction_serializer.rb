class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :status, :amount, :currency, :credit_card_id
end
