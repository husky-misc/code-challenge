# Creates processed_at & rejected_at fields to table rankings. (timestamps 20210508155222)

class AddProcessedAtAndRejectedAtOnRankings < ActiveRecord::Migration[6.0]
  def change
    change_table :rankings do |t|
      t.datetime :processed_at
      t.datetime :rejected_at
    end
  end
end
