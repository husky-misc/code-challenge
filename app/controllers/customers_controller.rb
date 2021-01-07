class CustomersController < ApplicationController
  def show
    transactions = @customer&.credit_cards&.map(:transactions)
    transactions_json = TransactionSerializer.new(transactions).serialized_json

    render json: transactions_json, status: 200
  rescue StandardError => e
    render json: { error: e.message }, status: 500
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
