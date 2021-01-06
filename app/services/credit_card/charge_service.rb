class CreditCard::ChargeService
  attr_reader :credit_card, :amount, :currency, :credit_card_transaction

  def initialize(credit_card, amount:, currency:)
    @credit_card = credit_card
    @amount = amount.to_i
    @currency = currency
    @credit_card_transaction = credit_card.transactions.build(amount: amount, currency: currency)
  end

  def call
    ActiveRecord::Base.transaction do
      credit_card_transaction.save!
      charge_card!
    rescue ActiveRecord::RecordInvalid
      raise ActiveRecord::Rollback
    end
  end

  private

  def charge_card!
    if credit_card.available_limit >= amount
      credit_card_transaction.pay!
      credit_card.update!(spent_limit: credit_card.spent_limit - amount)
    else
      credit_card_transaction.invalidate!
    end
  end
end
