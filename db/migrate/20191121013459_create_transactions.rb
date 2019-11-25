class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :currency
      t.string :credit_card
      t.integer :installments
      t.references :bank_statement, foreign_key: true

      t.timestamps
    end
  end
end
