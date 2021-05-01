class Match::FileImporter
  MATCH_STARTED = /^(?<started_at>\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2}) - New match (?<code>\d{8}) has started$/
  MATCH_ENDED = /^(?<ended_at>\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2}) - Match (?<code>\d{8}) has ended$/
  KILL = /^(?<killed_at>\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2}) - (?<killer>\w+) killed (?<killed>\w+) using (?<weapon>\w+)$/
  SUICIDE = /^(?<killed_at>\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2}) - <WORLD> killed (?<killed>\w+) by \w+$/
  MATCHES = Regexp.union(MATCH_STARTED, MATCH_ENDED, KILL, SUICIDE)

  attr_reader :file

  def initialize(file:)
    @file = file
  end

  def import
    file.each_line do |line|
      match = MATCHES.match(line)
      next unless match

      captures = extract_capture(match)

      case captures
      in { started_at: started_at, code: code } => params
        start_match(**params)
      in { ended_at: ended_at, code: code } => params
        end_match(**params)
      in { killed_at: killed_at, killer: killer, killed: killed, weapon: weapon } => params
        create_kill(**params)
      in { killed_at: killed_at, killed: killed } => params
        create_suicide(**params)
      end
    end
  end

  private

    def create_kill(killed_at:, killer:, killed:, weapon:)
      killer_player = Player.find_or_create_by(name: killer)
      killed_player = Player.find_or_create_by(name: killed)
      weapon_used = Weapon.find_or_create_by(name: weapon)
      @current_match.kills.create!(killed_at: killed_at, killer: killer_player, killed: killed_player, weapon: weapon_used)
    end

    def create_suicide(killed_at:, killed:)
      killed_player = Player.find_or_create_by(name: killed)
      @current_match.kills.create!(killed_at: killed_at, killed: killed_player)
    end

    def extract_capture(match)
      captures = match.named_captures
      captures.compact!
      captures.transform_keys!(&:to_sym)
      captures
    end

    def start_match(params)
      @current_match = Match.create!(params)
    end

    def end_match(ended_at:, code:)
      @current_match.update(ended_at: ended_at)
      @current_match = nil
    end
end
