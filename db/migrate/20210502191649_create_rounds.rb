class CreateRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :rounds do |t|
      execute "CREATE TYPE round_actions AS ENUM ('kill');"

      t.references :match, null: false, foreign_key: true
      t.jsonb :metadata, null: false, default: {}

      t.timestamps
    end

    add_column :rounds, :action, :round_actions, null: false
  end
end
