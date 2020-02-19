class Api::V1::BankStatementsController < ApplicationController

  def index
    @transactions = cache_block(record: bank_account, query: query_variation) do
      bank_account.transactions
      .days_ago(days_ago)
      .paginate(page: page_number,per_page: per_page)
    end
    render json: @transactions
  end

  private

  def query_variation
    "days_ago_#{days_ago}_page_#{page_number}_per_page_#{per_page}"
  end

  def bank_account
    BankAccount.find params[:bank_account_id]
  end

  def page_number
    params.dig("page","number")
  end

  def per_page
    params.dig("page","size")
  end

  def days_ago
    params["days"] || 30
  end
end
