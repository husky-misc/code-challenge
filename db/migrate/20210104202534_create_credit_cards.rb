class CreateCreditCards < ActiveRecord::Migration[6.0]
  def change
    create_table :credit_cards do |t|
      t.integer :spent_limit
      t.string :customer_full_name
      t.string :number
      t.date :expiration_date
      t.string :cvv
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
