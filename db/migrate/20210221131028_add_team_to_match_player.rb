class AddTeamToMatchPlayer < ActiveRecord::Migration[6.1]
  def change
    add_reference :match_players, :team, null: false, foreign_key: true
  end
end
