class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :status, :amount, :currency, :chargeable_id, :created_at

  def created_at
    object.created_at.iso8601
  end
end
