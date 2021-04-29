class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.integer :code
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
