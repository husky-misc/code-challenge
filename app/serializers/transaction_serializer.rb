class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :credit_card, :installments, :created_at, :updated_at

  belongs_to :bank_statement
  
end
