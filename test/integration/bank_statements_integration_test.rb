# frozen_string_literal: true

require 'test_helper'

class BankStatementsIntegrationTest < ActionDispatch::IntegrationTest
  attr_reader :account

  def setup
    @account = Account.create!
  end

  test 'returns the transactions based on the filter and the past balance of the account' do
    FactoryBot.create(:transaction, account: account, value: 42.50, created_at: 20.days.ago)
    FactoryBot.create(:transaction, account: account, value: 30.00, created_at: 25.days.ago)
    FactoryBot.create(:transaction, account: account, created_at: 10.days.ago, value: 42.42)
    FactoryBot.create(:transaction, account: account, created_at: 14.days.ago, value: 15.50)

    get bank_statement_path, params: { account_id: @account.id, filter_days: '15' }

    assert_response :ok
    json_body    = JSON.parse(response.body)['data']['attributes']
    transactions = json_body['transactions']
    assert_equal '72.5', json_body['past_balance']
    assert_equal 2, transactions.length
    assert_equal '42.42', transactions.first['value']
    assert_equal '15.5', transactions.second['value']
  end

  test 'returns the error if the filter is invalid' do
    get bank_statement_path, params: { account_id: @account.id, filter_days: '16' }

    json_body = JSON.parse(response.body)

    assert_response :bad_request
    assert json_body['errors']['days'].present?
  end
end
