class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :nickname, null: false, unique: true

      t.timestamps
    end
  end
end
