class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.datetime :started_at, null: false
      t.datetime :finished_at
      t.integer :external_id, null: false, unique: true
      t.integer :frags_count, null: false, default: 0

      t.timestamps
    end
  end
end
