class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :amount, :currency, :status
  belongs_to :credit_card
end
