class CreateKillLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :kill_logs do |t|
      t.references :match, null: false, foreign_key: true
      t.integer :killer_id
      t.integer :killed_id
      t.references :gun, null: false, foreign_key: true

      t.timestamps
    end
  end
end
