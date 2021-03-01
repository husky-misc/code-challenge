class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :match_id
      t.jsonb :ranking
      t.datetime :started_at
      t.datetime :finished_at
    end
  end
end
