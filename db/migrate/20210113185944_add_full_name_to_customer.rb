class AddFullNameToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :full_name, :string, null: false
  end
end
