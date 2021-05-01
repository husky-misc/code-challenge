class AddUniqueToMatchesCode < ActiveRecord::Migration[6.1]
  def change
    add_index :matches, :code, unique: true
  end
end
