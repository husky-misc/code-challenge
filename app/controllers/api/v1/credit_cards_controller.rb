class Api::V1::CreditCardsController < Api::V1::BaseController
  before_action :set_customer, :set_credit_card

  def charge
    transaction = @credit_card.charge(amount: params[:amount], currency: params[:currency])
    render_json(transaction, :created)
  end
end
