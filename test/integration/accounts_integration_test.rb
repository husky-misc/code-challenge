# frozen_string_literal: true

require 'test_helper'

class AccountsTestTest < ActionDispatch::IntegrationTest
  test 'creates an account with empty balance' do
    assert_difference -> { Account.count }, 1 do
      post accounts_path
    end

    assert_response :created
    json_body = JSON.parse(response.body)
    assert_equal '0.0', json_body['balance']
  end
end
