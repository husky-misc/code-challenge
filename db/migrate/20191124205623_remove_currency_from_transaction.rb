class RemoveCurrencyFromTransaction < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :currency, :string
  end
end
