class BankAccount < ApplicationRecord
  has_many :transactions
end
