class CreateCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.references :account, foreign_key: true, null: false

      t.integer :spent_limit, null: false
      t.string :number, null: false
      t.string :expiration_date, null: false
      t.string :cvv, null: false

      t.timestamps
    end
  end
end
