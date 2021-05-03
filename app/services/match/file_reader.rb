class Match::FileReader
  MATCH_STARTED = /^(?<started_at>\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2}) - New match (?<code>\d{8}) has started$/
  MATCH_ENDED = /^(?<ended_at>\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2}) - Match (?<code>\d{8}) has ended$/
  KILL = /^(?<killed_at>\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2}) - (?<killer>\w+) killed (?<killed>\w+) using (?<weapon>\w+)$/
  SUICIDE = /^(?<killed_at>\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2}) - <WORLD> killed (?<killed>\w+) by \w+$/
  MATCHES = Regexp.union(MATCH_STARTED, MATCH_ENDED, KILL, SUICIDE)
  
  def initialize(file:)
    @file = file
  end

  def each_match
    @file.each_line do |line|
      next if line.blank?
      match = MATCHES.match(line)
      next unless match

      captures = extract_captures(match)

      case captures
      in { started_at: started_at, code: code } => params
        @match_builder = Match::Builder.new
        @match_builder.start_match(**params)
      in { ended_at: ended_at, code: code } => params
        yield @match_builder.end_match(**params).build
      in { killed_at: killed_at, killer: killer, killed: killed, weapon: weapon } => params
        @match_builder.create_kill(**params)
      in { killed_at: killed_at, killed: killed } => params
        @match_builder.create_suicide(**params)
      end
    end
  end

  private

    def extract_captures(match)
      captures = match.named_captures
      captures.compact!
      captures.transform_keys!(&:to_sym)
      captures
    end
end
