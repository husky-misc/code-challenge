require 'test_helper'

class BankStatementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bank_statement = bank_statements(:one)
  end

  test "should get index" do
    get bank_statements_url, as: :json
    assert_response :success
  end

  test "should create bank_statement" do
    assert_difference('BankStatement.count') do
      post bank_statements_url, params: { bank_statement: { total: @bank_statement.total } }, as: :json
    end

    assert_response 201
  end

  test "should show bank_statement" do
    get bank_statement_url(@bank_statement), as: :json
    assert_response :success
  end

  test "should update bank_statement" do
    patch bank_statement_url(@bank_statement), params: { bank_statement: { total: @bank_statement.total } }, as: :json
    assert_response 200
  end

  test "should destroy bank_statement" do
    assert_difference('BankStatement.count', -1) do
      delete bank_statement_url(@bank_statement), as: :json
    end

    assert_response 204
  end
end
