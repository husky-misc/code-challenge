module Extractor
  class ExtractData
    attr_reader :lines
    attr_accessor :match

    def initialize(line)
      @lines = line.split("\n")
    end

    def extract
      lines.map do |line|
        if (line.match("New match"))
          match_data = Extractor::Match.new(line)

          self.match = ::Match.find_or_create_by(
            match_id: match_data.id,
            start_date: match_data.start_date_to_datetime
          )
        end  
        
        if(line.match("ended"))
          match_data = Extractor::Match.new(line)
          self.match.update(end_date: match_data.end_date_to_datetime)
        end

        if (line.match("killed"))
          score_data = Extractor::Score.new(line)
          gun = ::Gun.find_or_create_by(name: score_data.gun)

          if (score_data.killer != "<WORLD>")
            killer = ::Player.find_or_create_by(name: score_data.killer)
            ::Frag.create(player: killer, gun: gun, match: match, date: score_data.start_date_to_datetime)
          end

          victim = ::Player.find_or_create_by(name: score_data.victim)
          ::Death.create(player: victim, gun: gun, match: match, date: score_data.start_date_to_datetime)
        end
      end
    end
  end
end