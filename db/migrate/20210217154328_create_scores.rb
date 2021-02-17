class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.references :player, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true
      t.references :gun, null: false, foreign_key: true
      t.datetime :date
      t.string :type

      t.timestamps
    end
  end
end
