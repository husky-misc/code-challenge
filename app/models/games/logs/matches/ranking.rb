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

  def deaths_count
    events.group_by { |e| e[:victim] }.transform_values(&:size)
  end

  def deaths?(player_name)
    deaths_count.find { |k, _| k == player_name }.present?
  end

  def players_weapons
    frags.transform_values { |v| v.group_by { |e| e[:weapon] }.transform_values(&:count) }
  end

  def kill_five_times_on_a_minute?(player_name)
    return false unless frags?(player_name)

    frags[player_name].group_by { |e| e[:datetime].min }
                      .transform_values(&:count)
                      .select { |_, value| value >= 5 }
                      .present?
  end

  def award?(player_name)
    !deaths?(player_name) || kill_five_times_on_a_minute?(player_name)
  end

  attr_reader :events, :players
end
