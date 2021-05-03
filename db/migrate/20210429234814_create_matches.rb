class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.integer :code
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
