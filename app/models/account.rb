class Account < ApplicationRecord
  belongs_to :customer, required: true
  has_many :credit_cards

  validates_uniqueness_of :customer_id
end
