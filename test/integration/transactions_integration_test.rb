# frozen_string_literal: true

require 'test_helper'

class TransactionsIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    @account = Account.create!
  end

  test 'creates the transaction with positive value if it is a credit' do
    assert_difference -> { Transaction.count }, 1 do
      post transactions_path, params: { account_id: @account.id, transaction: { type: 'credit', value: '100.53' } }
    end

    assert_response :created
    json_body = JSON.parse(response.body)['data']['attributes']
    assert_equal 100.53, Transaction.last.value
    assert_equal '100.53', json_body['value']
    assert_equal 'credit', json_body['operation_type']
  end

  test 'creates the transaction with negative value if it is a debit' do
    assert_difference -> { Transaction.count }, 1 do
      post transactions_path, params: { account_id: @account.id, transaction: { type: 'debit', value: '100.53' } }
    end

    assert_response :created
    json_body = JSON.parse(response.body)['data']['attributes']
    assert_equal (-100.53), Transaction.last.value
    assert_equal '100.53', json_body['value']
    assert_equal 'debit', json_body['operation_type']
  end

  test 'does not create the transaction with invalid values' do
    assert_difference -> { Transaction.count }, 0 do
      post transactions_path, params: { account_id: @account.id, transaction: { type: 'idontknow', value: '100.53' } }
    end

    assert_response :bad_request
    json_body = JSON.parse(response.body)
    assert json_body['errors'].present?
  end

  test 'updates the user ballance with the credit' do
    post transactions_path, params: { account_id: @account.id, transaction: { type: 'credit', value: '200.34' } }

    assert_response :created
    assert_equal 200.34, @account.reload.balance
  end

  test 'updates the user ballance with the debit' do
    @account.update(balance: 100.00)

    post transactions_path, params: { account_id: @account.id, transaction: { type: 'debit', value: '20.42' } }

    assert_response :created
    assert_equal 79.58, @account.reload.balance
  end
end
