module Chargeable
  extend ActiveSupport::Concern

  included do
    has_many :transactions, as: :chargeable

    def charge!(amount:, currency:)
      self.transactions.create!(amount: amount, currency: currency)
    end
  end
end
