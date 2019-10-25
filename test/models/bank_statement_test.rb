require 'test_helper'

class BankStatementTest < ActiveSupport::TestCase
  def setup
    @account = Account.create!
  end

  test '#transactions returns the transactions for the informed filter' do
    old_transaction      = FactoryBot.create(:transaction, account: @account, created_at: 20.days.ago)
    included_transaction = FactoryBot.create(:transaction, account: @account, created_at: 15.days.ago)
    statement = BankStatement.new(account: @account, days: 15)

    transactions = statement.transactions

    refute_includes transactions, old_transaction
    assert_includes transactions, included_transaction
  end

  test '#past_balance returns the balance of transactions not in filter' do
    FactoryBot.create(:transaction, account: @account, created_at: 20.days.ago, value: 15.50)
    FactoryBot.create(:transaction, account: @account, created_at: 20.days.ago, value: 20.00)
    _included_transaction = FactoryBot.create(:transaction, account: @account, created_at: 15.days.ago)

    statement = BankStatement.new(account: @account, days: 15)

    past_balance = statement.past_balance

    assert_equal 35.50, past_balance
  end
end
