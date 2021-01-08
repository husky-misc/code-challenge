# frozen_string_literal: true

class Customer < ApplicationRecord
  has_one :account, dependent: :destroy
  has_many :credit_cards, through: :account

  validates_presence_of :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end
end
