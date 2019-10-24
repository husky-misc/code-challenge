class TransactionsController < ApplicationController
  def create
    operation = Operation.new(account: current_account, type: transaction_params[:type], value: transaction_params[:value])

    if operation.valid?
      transaction = operation.transact!
      render json: TransactionSerializer.new(transaction), status: :created
    else
      render json: { errors: operation.errors }, status: :bad_request
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:type, :value)
  end
end
