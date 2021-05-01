class AddUniqueToWeaponsName < ActiveRecord::Migration[6.1]
  def change
    add_index :weapons, :name, unique: true
  end
end
