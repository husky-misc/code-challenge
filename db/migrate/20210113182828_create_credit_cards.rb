class CreateCreditCards < ActiveRecord::Migration[6.0]
  def change
    create_table :credit_cards do |t|
      t.references :account, null: false, foreign_key: true
      t.integer :spent_limit, null: false
      t.string :number, null: false
      t.date :expiration_date, null: false
      t.string :cvv, null: false
      t.string :full_name, null: false

      t.timestamps
    end
  end
end
