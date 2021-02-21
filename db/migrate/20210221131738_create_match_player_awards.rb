class CreateMatchPlayerAwards < ActiveRecord::Migration[6.1]
  def change
    create_table :match_player_awards do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :award, null: false, foreign_key: true

      t.timestamps
    end
  end
end
