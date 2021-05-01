class Match::RankQuery
  def initialize(match)
    @match = match
  end

  def call
    @match.kills
      .joins("INNER JOIN players ON players.id = kills.killer_id OR players.id = kills.killed_id")
      .group("players.id","players.name")
      .order("frag DESC, deaths")
      .pluck(
        "players.name",
        Arel.sql("SUM(CASE players.id WHEN kills.killer_id THEN 1 ELSE 0 END) AS frag"),
        Arel.sql("SUM(CASE players.id WHEN kills.killed_id THEN 1 ELSE 0 END) AS deaths")
      )
  end
end
