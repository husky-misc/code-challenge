class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.string :match_id
      t.text :match_log
      t.datetime :match_begin
      t.datetime :match_end

      t.timestamps
    end
  end
end
