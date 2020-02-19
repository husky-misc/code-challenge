class Api::V1::BankAccountsController < ApplicationController

  def index
    @bank_accounts = BankAccount.all
    render json: @bank_accounts
  end

  def create
    @bank_account = BankAccount.create(bank_account_params)
  end

  private

  def bank_account_params
    permit(:default_currency)
  end
end
