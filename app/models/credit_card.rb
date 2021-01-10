class CreditCard < ApplicationRecord
  belongs_to :account
  delegate :customer, to: :account
  has_many :transactions

  include Chargeable

  validates :spent_limit, numericality: { greater_than_or_equal_to: 0 }
  validates_presence_of(
    :account_id, :spent_limit, :number, :expiration_date, :cvv
  )

  def charge!(params)
    Charge.new(
      credit_card: self,
      amount: params[:amount],
      currency: params[:currency]
    ).call
  end

  def withdraw(amount)
    self.update!(spent_limit: spent_limit - amount)
  end

  def restore_limit(amount)
    self.update!(spent_limit: spent_limit + amount)
  end
end
