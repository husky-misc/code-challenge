# Creates the logs table (timestamps 20210508035030)

class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.string :game_mode, null: false
      t.string :description
      t.boolean :is_valid, default: false, null: false

      t.timestamps
    end
  end
end
