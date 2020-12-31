class Api::V1::TransactionsController < Api::V1::ApiBaseController
  def index
    @transactions = Transaction.page(params[:page])
    render json: @transactions
  end
end
