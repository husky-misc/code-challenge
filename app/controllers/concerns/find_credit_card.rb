module FindCreditCard
  extend ActiveSupport::Concern

  included do
    before_action :set_credit_card
  end

  private

  def set_credit_card
    @credit_card = CreditCard.find(credit_card_id[:credit_card_id])
  end

  def credit_card_id
    params.permit(:credit_card_id)
  end
end
