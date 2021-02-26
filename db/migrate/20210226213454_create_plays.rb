class CreatePlays < ActiveRecord::Migration[6.0]
  def change
    create_table :plays do |t|
      t.references :match, foreign_key: true, null: false
      t.references :killer, { to_table: 'players' }
      t.references :victim, { to_table: 'players' }
      t.references :weapon, foreign_key: true
      t.datetime :gametime, null: false

      t.timestamps
    end
  end
end
