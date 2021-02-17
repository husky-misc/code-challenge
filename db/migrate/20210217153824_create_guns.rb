class CreateGuns < ActiveRecord::Migration[6.1]
  def change
    create_table :guns do |t|
      t.string :name
      t.string :string

      t.timestamps
    end
  end
end
