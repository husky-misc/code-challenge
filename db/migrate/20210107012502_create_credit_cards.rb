class CreateCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.references :account, null: false, foreign_key: true
      t.integer :spent_limit
      t.string :number
      t.datetime :expiration_date
      t.string :cvv

      t.timestamps
    end
  end
end
