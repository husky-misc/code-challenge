class ChangeTransactionAttributesToNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :amount, :float, null: false
    change_column :transactions, :currency, :string, null: false
    change_column :transactions, :status, :integer, null: false
  end
end
