# frozen_string_literal: true

class CreditCard < ApplicationRecord
  belongs_to :account
  has_many :transactions

  validates_presence_of :spent_limit,
                        :customer_full_name,
                        :number,
                        :expiration_date,
                        :cvv,
                        :flag
end
