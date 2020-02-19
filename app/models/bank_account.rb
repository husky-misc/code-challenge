class BankAccount < ApplicationRecord
  has_many :transactions, dependent: :destroy
end
