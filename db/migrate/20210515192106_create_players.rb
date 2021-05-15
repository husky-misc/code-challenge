class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.belongs_to :match, index: true, null: false, foreign_key: true

      t.string :name, null: false
      t.integer :frags
      t.integer :deads
      t.boolean :awarded, null: false, default: false
      t.string :strong_weapon
      t.boolean :strong_killer
      t.integer :score

      t.timestamps
    end

    add_index :matches, %i[match_id name], unique: true, name: 'unique_name_by_match'
  end
end
