class Api::V1::BankStatementsController < ApplicationController

  def index
    @transactions = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      bank_account.transactions
                  .days_ago(days_ago)
                  .paginate(page: page_number,per_page: per_page).to_a
    end
    render json: @transactions
  end

  private

  def cache_key
    "#{bank_account.cache_key_with_version}_days_ago_#{days_ago}_page_#{page_number}_per_page_#{per_page}"
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
