# frozen_string_literal: true

class BankStatement
  include ActiveModel::Validations

  attr_reader :account, :days

  ALLOWED_DAYS_TO_FILTER = [3, 15, 30]

  validates :days, inclusion: { in: ALLOWED_DAYS_TO_FILTER }

  def initialize(account:, days:)
    @account = account
    @days    = days.to_i
  end

  def transactions
    @transactions ||= @account.transactions.filter_days(days)
  end

  def past_balance
    @past_balance ||= @account.transactions.past_balance(days)
  end
end
