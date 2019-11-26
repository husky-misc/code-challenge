class BankStatementSerializer < ActiveModel::Serializer
  attributes :id, :total, :created_at, :updated_at

  link(:self) { v1_bank_statement_url(object.id) }

  has_many :transactions do
    link(:related) { v1_bank_statement_transactions_url(object.id) }
  end
end
