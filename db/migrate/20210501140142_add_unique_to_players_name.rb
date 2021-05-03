class AddUniqueToPlayersName < ActiveRecord::Migration[6.1]
  def change
    add_index :players, :name, unique: true
  end
end
