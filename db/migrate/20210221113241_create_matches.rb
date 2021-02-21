class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.string :winner
      t.string :loser

      t.timestamps
    end
  end
end
