class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.integer :match_id
      t.string :player1
      t.string :player2
      t.string :weapon
      t.belongs_to :stat

      t.timestamps
    end
  end
end
