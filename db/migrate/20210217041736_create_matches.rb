class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.string :match_id
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
