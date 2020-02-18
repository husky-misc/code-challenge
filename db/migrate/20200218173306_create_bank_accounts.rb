class CreateBankAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_accounts do |t|
      t.decimal       :current_balance, precision: 10, scale: 2, default: 0
      t.string        :default_currency, default: 'BRL'
      t.timestamps
    end
  end
end
