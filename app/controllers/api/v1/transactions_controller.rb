class Api::V1::TransactionsController < Api::V1::ApiBaseController
  before_action :set_customer, :set_credit_card

  def index
    status = transaction_params[:status]

    if status.present?
      check_status(status)

      @transactions =
        @credit_card.transactions.send(status).page(transaction_params[:page])
    else
      @transactions = @credit_card.transactions.page(transaction_params[:page])
    end
  end

  private

  def check_status(status)
    render_error('Status not found') unless Transaction.statuses.include? status
  end

  def render_error(message)
    render json: {error: message}, status: 404
  end

  def set_customer
    @customer = Customer.find(transaction_params[:customer_id])
  end

  def set_credit_card
    @credit_card = @customer.credit_cards.find(transaction_params[:credit_card_id])
  end

  def transaction_params
    params.permit(:page, :customer_id, :credit_card_id, :status)
  end
end
