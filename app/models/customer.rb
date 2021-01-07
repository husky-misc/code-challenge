class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_one :account

  has_many :credit_cards, through: :account
  has_many :transactions, through: :credit_cards

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ').titleize
  end
end
