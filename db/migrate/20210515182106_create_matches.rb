class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.belongs_to :ranking, index: true, null: false, foreign_key: true

      t.integer :frags, null: false, default: 0
      t.datetime :started_at, null: false
      t.datetime :ended_at, null: false
      t.string :match_code, null: false
      t.json :content, null: false
      t.string :strike_player
      t.string :winner

      t.timestamps
    end
  end
end
