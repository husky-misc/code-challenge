class CreateGuns < ActiveRecord::Migration[6.1]
  def change
    create_table :guns do |t|
      t.string :name

      t.timestamps
    end
  end
end
