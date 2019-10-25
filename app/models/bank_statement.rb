# frozen_string_literal: true

require 'caching'

class BankStatement
  include ActiveModel::Validations
  include Caching::CacheableResource

  attr_reader :account, :days

  ALLOWED_DAYS_TO_FILTER = [3, 15, 30]

  validates :days, inclusion: { in: ALLOWED_DAYS_TO_FILTER }

  cache_options default_cache_warm_with: {account: -> { Account.pluck(:id).map { |id| Account.new(id: id) } }, days: ALLOWED_DAYS_TO_FILTER}

  def initialize(account:, days:)
    @account = account
    @days    = days.to_i
  end

  def custom_cache_keys
    [account.id, days]
  end

  def transactions
    @transactions ||= @account.transactions.filter_days(days).to_a
  end
  cache :transactions

  def past_balance
    @past_balance ||= @account.transactions.past_balance(days)
  end
  cache :past_balance
end
