class CreateStats < ActiveRecord::Migration[6.1]
  def change
    create_table :stats do |t|
      t.string :player
      t.integer :kills
      t.integer :death

      t.timestamps
    end
  end
end
