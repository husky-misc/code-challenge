class CreateBankStatements < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_statements do |t|
      t.decimal :total

      t.timestamps
    end
  end
end
