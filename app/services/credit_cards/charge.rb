module CreditCards
  class Charge
    def initialize(credit_card:, amount:, currency:)
      @credit_card = credit_card
      @amount = amount
      @currency = currency
    end

    attr_reader :credit_card, :amount, :currency

    def call
      ActiveRecord::Base.transaction do
        return false unless credit_card.charge!(amount: amount, currency: currency)

        credit_card.withdraw!(amount)
      end
    end
  end
end
