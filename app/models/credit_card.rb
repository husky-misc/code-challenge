# frozen_string_literal: true

class CreditCard < ApplicationRecord
  belongs_to :account
  has_many :transactions
end
