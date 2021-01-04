# frozen_string_literal: true

class Customer < ApplicationRecord
  has_one :account
  has_many :credit_cards, through: :account
end
