class CreateKills < ActiveRecord::Migration[6.1]
  def change
    create_table :kills do |t|
      t.datetime :killed_at
      t.references :match, null: false, foreign_key: true
      t.references :killer, null: true, foreign_key: { to_table: :players }
      t.references :killed, null: false, foreign_key: { to_table: :players }
      t.references :weapon, null: true, foreign_key: true

      t.timestamps
    end
  end
end
