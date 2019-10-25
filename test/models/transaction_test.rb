require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test 'does not allow an invalid operation type' do
    transaction = Transaction.new(operation_type: 'idontknow', value: 1)

    refute transaction.valid?
    assert transaction.errors['operation_type'].present?
  end

  test 'does not allow a negative value for credit operation' do
    transaction = Transaction.new(operation_type: Transaction::CREDIT, value: -1)

    refute transaction.valid?
    assert transaction.errors['value'].present?
  end

  test 'does not allow a positive value for debit operation' do
    transaction = Transaction.new(operation_type: Transaction::DEBIT)
    transaction.value = 10.0

    refute transaction.valid?
    assert transaction.errors['value'].present?
  end

  test 'negate the value when initialize with a debit operation' do
    transaction = Transaction.new(operation_type: Transaction::DEBIT, value: 42)

    assert_equal -42, transaction.value
  end

  test '.filter_days returns transactions in the filter period' do
    first_included_transaction  = FactoryBot.create(:transaction, created_at: 8.days.ago)
    second_included_transaction = FactoryBot.create(:transaction, created_at: 15.days.ago)
    non_included_transaction    = FactoryBot.create(:transaction, created_at: 16.days.ago)

    filtered_transactions = Transaction.all.filter_days(15)

    assert_includes filtered_transactions, first_included_transaction
    assert_includes filtered_transactions, second_included_transaction
    refute_includes filtered_transactions, non_included_transaction
  end

  test '.past_balance returns the balance with transactions before the filter' do
    FactoryBot.create(:transaction, value: 20, created_at: 16.days.ago)
    FactoryBot.create(:transaction, value: 30, created_at: 17.days.ago)

    past_balance = Transaction.all.past_balance(15)

    assert_equal 50.0, past_balance
  end

  test '#display_value shows the absolute value' do
    debit_transaction = Transaction.new(operation_type: 'debit', value: -42)
    assert_equal 42, debit_transaction.display_value

    credit_transaction = Transaction.new(operation_type: 'credit', value: 42)
    assert_equal 42, credit_transaction.display_value
  end

  test '#credit? returns true if a credit operation' do
    transaction = Transaction.new(operation_type: Transaction::CREDIT)

    assert transaction.credit?
    refute transaction.debit?
  end

  test '#debit? returns true if a debit operation' do
    transaction = Transaction.new(operation_type: Transaction::DEBIT)

    assert transaction.debit?
    refute transaction.credit?
  end
end
