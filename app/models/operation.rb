# frozen_string_literal: true
class Operation
  def initialize(account:, type:, value:)
    @account     = account
    @transaction = Transaction.new(account: account, operation_type: type.downcase, value: value)
  end

  def valid?
    @transaction.valid?
  end

  def errors
    @transaction.errors.messages
  end

  def transact!
    Transaction.transaction do
      @account.with_lock do
        @transaction.save!
        Account.where(id: @transaction.account_id).update_all(['balance = balance + ?', @transaction.value])
        BankStatement.invalidate_cache_for(@account.id)
      end
    end
    @transaction
  end
end
