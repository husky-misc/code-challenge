class AddFlagToCreditCard < ActiveRecord::Migration[6.0]
  def change
    add_column :credit_cards, :flag, :string, null: false
  end
end
