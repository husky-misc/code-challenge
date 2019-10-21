class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.decimal :balance, null: false, default: 0

      t.timestamps
    end
  end
end
