class CreditCard::TransactionSerializer < ActiveModel::Serializer
  attributes :id, :created, :status, :amount, :currency, :credit_card_id

  def created
    object.created_at.to_i
  end
end
