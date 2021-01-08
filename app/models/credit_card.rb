# frozen_string_literal: true

class CreditCard < ApplicationRecord
  belongs_to :account
  has_many :transactions, dependent: :destroy

  validates_presence_of :spent_limit,
                        :customer_full_name,
                        :number,
                        :expiration_date,
                        :cvv,
                        :flag

  def expired?
    Date.today > expiration_date
  end

  def decrease_limit(amount)
    self.spent_limit -= amount

    save!
  end

  def back_limit(amount)
    self.spent_limit += amount

    save!
  end
end
