class CreateNumbers < ActiveRecord::Migration[5.1]
  def change
    create_table :numbers do |t|
      t.integer :value

      t.timestamps
    end
  end
end
