class ChangeTransactionAttributesToNotNull < ActiveRecord::Migration[6.0]
  def up
    change_column :transactions, :amount, :float, null: false
    change_column :transactions, :currency, :string, null: false
    change_column :transactions, :status, :integer, null: false
  end

  def down 
    change_column :transactions, :status, :integer, null: true
    change_column :transactions, :currency, :string, null: true
    change_column :transactions, :amount, :float, null: true
  end
end
