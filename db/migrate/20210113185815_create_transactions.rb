class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :credit_card, null: false, foreign_key: true
      t.string :currency
      t.float :amount
      t.integer :status

      t.timestamps
    end
  end
end
