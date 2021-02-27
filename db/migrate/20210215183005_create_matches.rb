class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.string :match_id
      t.index :match_id, unique: true
      t.text :file
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
