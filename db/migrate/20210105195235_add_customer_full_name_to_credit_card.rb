class AddCustomerFullNameToCreditCard < ActiveRecord::Migration[6.1]
  def change
    add_column :credit_cards, :customer_full_name, :string, null: false
  end
end
