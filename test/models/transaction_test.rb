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
