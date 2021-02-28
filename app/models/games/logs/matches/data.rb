# frozen_string_literal: true

class Games::Logs::Matches::Data
  def initialize(match)
    @match = match
  end

  def id
    match.first[:event].match(/\d+/).to_s
  end

  def started_at
    match.first[:datetime]
  end

  def finished_at
    match.last[:datetime]
  end

  def events_list
    events.each_with_object([]) do |kill, array|
      attacker, victim, _, weapon = kill[:event].match(FRAG_REGEX).captures

      frag =
        {
          datetime: DateTime.parse(kill[:datetime]),
          attacker: attacker,
          victim: victim,
          weapon: weapon
        }

      array << frag
    end
  end

  def players
    events_list.each_with_object([]) do |event, array|
      attacker, victim = event.values_at(:attacker, :victim)

      array << attacker unless attacker == '<WORLD>'
      array << victim
    end.uniq
  end

  private

  FRAG_REGEX = /(.+) killed (.+) (by|using) (.+)/

  attr_reader :match

  def events
    match[1..match.size - 2]
  end
end
