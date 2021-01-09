module Chargeable
  extend ActiveSupport::Concern

  included do
    has_many :transactions, as: :chargeable

    def charge!(amount:, currency:)
      transaction = self.transactions.new(amount: amount, currency: currency)
      transaction.pay!
      return false if transaction.failed?

      true
    end
  end
end
