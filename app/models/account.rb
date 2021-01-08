# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :customer
  has_many :credit_cards, dependent: :destroy
end
