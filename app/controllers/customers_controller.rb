class CustomersController < ApplicationController
  def show
    transactions = @customer.transactions
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
