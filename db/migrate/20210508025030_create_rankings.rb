# Creates the rankings table (timestamps 20210508025030)

class CreateRankings < ActiveRecord::Migration[6.0]
  def change
    create_table :rankings do |t|
      t.belongs_to :log, index: true, null: false, foreign_key: true
      t.string :status, default: :pending, null: false

      t.timestamps
    end
  end
end
