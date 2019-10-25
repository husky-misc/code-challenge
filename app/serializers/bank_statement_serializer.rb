class BankStatementSerializer
  include FastJsonapi::ObjectSerializer
  attributes :transactions, :past_balance
  set_id { |statement| statement.account.id }
end
