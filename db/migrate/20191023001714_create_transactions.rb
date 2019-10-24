class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.decimal :value, null: false, default: 0
      t.string :operation_type, null: false

      t.timestamps
    end
    add_index :transactions, :operation_type
    add_index :transactions, :created_at
  end
end
