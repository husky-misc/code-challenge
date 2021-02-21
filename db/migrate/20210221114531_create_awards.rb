class CreateAwards < ActiveRecord::Migration[6.1]
  def change
    create_table :awards do |t|
      t.string :name
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
