class Transaction < ApplicationRecord
  enum transaction_type: [:credit, :debit]
  belongs_to :bank_account
end
