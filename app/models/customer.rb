class Customer < ApplicationRecord
  has_one :account
  has_many :credit_cards, through: :account
  has_many :transactions, through: :credit_cards

  validates_presence_of :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end
end
