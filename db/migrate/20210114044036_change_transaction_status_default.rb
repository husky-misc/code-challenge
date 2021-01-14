class ChangeTransactionStatusDefault < ActiveRecord::Migration[6.0]
  def up
    change_column :transactions, :status, :integer, default: 0
  end

  def down 
    change_column :transactions, :status, :integer, default: nil
  end
end
