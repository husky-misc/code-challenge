class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    drop_table :transactions
    create_table :transactions do |t|
      t.decimal :amount
      t.string :currency
      t.string :credit_card
      t.integer :installments

      t.timestamps
    end
  end
end
