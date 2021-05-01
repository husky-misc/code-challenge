class Match < ApplicationRecord
  MATCH_STARTED = /^(?<started_at>\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2}) - New match (?<code>\d{8}) has started$/
  MATCH_ENDED = /^(?<ended_at>\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2}) - Match (?<code>\d{8}) has ended$/
  KILL = /^(?<killed_at>\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2}) - (?<killer>\w+) killed (?<killed>\w+) using (?<weapon>\w+)$/
  SUICIDE = /^(?<killed_at>\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2}) - <WORLD> killed (?<killed>\w+) by \w+$/
  MATCHES = Regexp.union(MATCH_STARTED, MATCH_ENDED, KILL, SUICIDE)

  def self.import(file:)
    current_match = nil

    file.each_line do |line|
      match = MATCHES.match(line)
      next unless match

      captures = match.named_captures
      captures.compact!
      captures.transform_keys!(&:to_sym)

      case captures
      in { started_at: started_at, code: code } => match_attrs
        current_match = Match.create!(match_attrs)
      in { ended_at: ended_at, code: code }
        Match.find_by(code: code).update(ended_at: ended_at)
        current_match = nil
      in { killed_at: killed_at, killer: killer, killed: killed, weapon: weapon }
        killer_player = Player.find_or_create_by(name: killer)
        killed_player = Player.find_or_create_by(name: killed)
        weapon_used = Weapon.find_or_create_by(name: weapon)
        Kill.create!(match: current_match, killed_at: killed_at, killer: killer_player, killed: killed_player, weapon: weapon_used)
      in { killed_at: killed_at, killed: killed }
        killed_player = Player.find_or_create_by(name: killed)
        Kill.create!(match: current_match, killed_at: killed_at, killed: killed_player)
      end
    end
  end
end
