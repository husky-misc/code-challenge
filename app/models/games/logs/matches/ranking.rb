# frozen_string_literal: true

class Games::Logs::Matches::Ranking
  def initialize(players, events)
    @players = players
    @events = events
  end

  def to_a
    players.each_with_object([]) do |player_name, array|
      rank = {
        name: player_name,
        frags: frags_count[player_name] || 0,
        deaths: deaths_count[player_name] || 0,
        award: award?(player_name),
        streak: streaks(player_name),
        weapon: factal_weapon(player_name)

      }
      array << rank
    end
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

  def dont_have_streaks?(player_name)
    deaths_count.key?(player_name) || !frags_count.key?(player_name)
  end

  def streaks(player_name)
    return 0 if dont_have_streaks?(player_name)

    frags_count[player_name]
  end

  def factal_weapon(player_name)
    player_weapons = players_weapons[player_name]

    return 'no kills, no factal weapon' if player_weapons.nil?

    player_weapons.key(player_weapons.values.max)
  end

  private

  attr_reader :events, :players
end
