class CustomersController < ApplicationController
  before_action :set_customer, only: [:credit_card_transactions]

  def credit_card_transactions
    credit_card = @customer.credit_cards.find(params[:credit_card_id])

    transactions = Transaction.filter(credit_card: credit_card, status: params[:status]).page(params[:page] || 1).per(params[:limit] || 5)

    render json: transactions, meta: pagination_info(transactions)
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
