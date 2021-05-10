class CreateRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :rounds do |t|
      t.references :match, null: false, foreign_key: true
      t.jsonb :metadata, null: false, default: {}
      t.string :action, null: false

      t.timestamps
    end
  end
end
