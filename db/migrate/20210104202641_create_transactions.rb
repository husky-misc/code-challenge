class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :credit_card, null: false, foreign_key: true
      t.integer :amount
      t.string :currency
      t.string :status

      t.timestamps
    end
  end
end
