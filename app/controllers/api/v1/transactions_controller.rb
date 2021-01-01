class Api::V1::TransactionsController < Api::V1::ApiBaseController
  def index
    status = transaction_params[:status]

    if status.present?
      return not_found('Status not found') unless status_valid?(status)

      @transactions =
        @credit_card.transactions.send(status).page(transaction_params[:page])
    else
      @transactions = @credit_card.transactions.page(transaction_params[:page])
    end
  end

  private

  def status_valid?(status)
    Transaction.statuses.include? status
  end

  def transaction_params
    params.permit(:page, :status)
  end
end
