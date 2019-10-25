class BankStatementsController < ApplicationController
  def show
    bank_statement = BankStatement.new(account: current_account, days: params[:filter_days])

    if bank_statement.valid?
      render json: BankStatementSerializer.new(bank_statement), status: :ok
    else
      render json: { errors: bank_statement.errors }, status: :bad_request
    end
  end
end
