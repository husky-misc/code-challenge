class BankStatementSerializer
  include FastJsonapi::ObjectSerializer
  attributes :transactions, :past_balance
  cache_options enabled: true
  set_id { |statement| statement.account.id }
end
