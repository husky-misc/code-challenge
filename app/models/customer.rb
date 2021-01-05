class Customer < ApplicationRecord
  has_one :account
  has_many :credit_cards, through: :account

  with_options presence: true do
    validates :first_name
    validates :last_name
  end

  after_create :create_account

  def full_name
    "#{first_name} #{last_name}"
  end
end
