class CustomersController < ApplicationController
  before_action :set_customer, only: [:credit_card_transactions, :charge_credit_card]
  before_action :set_credit_card, only: [:credit_card_transactions, :charge_credit_card]


  def credit_card_transactions
    transactions = Transaction.filter(credit_card: @credit_card, status: params[:status]).page(params[:page] || 1).per(params[:limit] || 5)

    render json: transactions, meta: pagination_info(transactions)
  end

  def charge_credit_card
    transaction = @credit_card.transactions.new(transaction_params)

    transaction.check_state

    if transaction.save
      render json: transaction
    else
      render json: transaction.errors.full_messages, status: :unprocessable_entity
    end

  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def set_credit_card
    @credit_card = @customer.credit_cards.find(params[:credit_card_id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :currency)
  end
end
