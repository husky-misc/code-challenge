class Charge
  attr_reader :amount, :currency, :credit_card, :transaction

  def initialize(credit_card:, amount:, currency:)
    @credit_card = credit_card
    @amount = amount
    @currency = currency
    @transaction = build_transaction
  end

  def call
    transaction.pay!

    transaction
  end

  private

  def build_transaction
    @credit_card.transactions.new(amount: amount, currency: currency)
  end
end
