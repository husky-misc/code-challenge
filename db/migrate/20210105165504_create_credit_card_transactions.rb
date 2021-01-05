class CreateCreditCardTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_card_transactions do |t|
      t.references :credit_card, foreign_key: true, null: false

      t.string :status, null: false
      t.integer :amount, null: false
      t.string :currency, null: false

      t.timestamps
    end
  end
end
