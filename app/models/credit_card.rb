class CreditCard < ApplicationRecord
  include Chargeable

  delegate :customer, to: :account
  delegate :full_name, to: :customer

  validates_numericality_of :spent_limit, greater_than: 0
  validates_presence_of :account_id, :spent_limit, :number, :expiration_date, :cvv

  belongs_to :account
end
