class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string        :description
      t.integer       :transaction_type
      t.decimal       :amount, precision: 10, scale: 2
      t.decimal       :balance, precision: 10, scale: 2
      t.decimal       :previous_balance, precision: 10, scale: 2
      t.references    :bank_account, index: true
      t.timestamps
    end
  end
end
