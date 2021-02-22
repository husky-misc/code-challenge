class FiveKillsStreak
  attr_reader :player, :match_id

  def initialize(player, match_id)
    @player = player
    @match_id = match_id
  end

  def award
    player.frags.map do |frag|
      player.frags.where(date: frag.date..frag.date + 1.minutes).size >= 5
    end.any?(true)
  end
end