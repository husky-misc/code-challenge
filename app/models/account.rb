class Account < ApplicationRecord
  belongs_to :customer
  has_many :credit_cards
end
