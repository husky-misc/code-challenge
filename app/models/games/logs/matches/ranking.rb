# frozen_string_literal: true

class Games::Logs::Matches::Ranking
  def initialize(players, events)
    @players = players
    @events = events
  end

  def frags
    events.group_by { |e| e[:attacker] }
  end

  def frags_count
    frags.transform_values(&:size)
  end

  def frags?(player_name)
    frags_count.find { |k, _| k == player_name }.present?
  end

  attr_reader :events, :players
end
