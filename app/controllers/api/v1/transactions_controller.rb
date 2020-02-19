require 'faker'

class Api::V1::TransactionsController < ApplicationController

  def create
    # Only for test puporse (dos not need params)
    bank_account.transactions.create(description: "#{Faker::Games::Witcher.character} oren transfer",
                                transaction_type: rand(0..1),
                                amount: rand(0.0..2000.0).ceil(2))
    #TODO: transaction should be created using a Service to calculate balances
    # We can get balance also via bank statements thats should use a service
    # to calculate balances (in this approach is recommended create a record to save bank statements)
  end

  private

  def bank_account
    BankAccount.find params[:bank_account_id]
  end

end
