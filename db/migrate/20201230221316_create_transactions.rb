class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :credit_card, null: false, foreign_key: true
      t.integer :status
      t.integer :amount
      t.string :currency

      t.timestamps
    end
  end
end
