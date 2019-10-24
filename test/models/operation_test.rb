require 'test_helper'

class OperationTest < ActiveSupport::TestCase
  def setup
    @account = Account.create!(balance: 20.0)
  end

  test 'saves the transaction if it is valid' do
    operation = Operation.new(type: 'credit', value: 100.5, account: @account)

    transaction = operation.transact!

    assert transaction.persisted?
  end

  test 'negates the value if it is a debit operation' do
    operation = Operation.new(type: 'debit', value: 42, account: @account)

    transaction = operation.transact!

    assert_equal (-42), transaction.value
  end

  test 'updates the account balance with the new value' do
    operation = Operation.new(type: 'credit', value: 150.10, account: @account)

    operation.transact!

    assert_equal 170.10, @account.reload.balance
  end

  test '#valid? returns true if transaction is valid' do
    operation = Operation.new(type: 'credit', value: 1, account: @account)

    assert operation.valid?
  end

  test '#valid? returns false if transaction is invalid' do
    operation = Operation.new(type: 'idontknow', value: 1, account: @account)

    refute operation.valid?
  end
end
