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

          self.match = ::Match.create(
            match_id: match_data.id,
            start_date: match_data.start_date_to_datetime
          )
        end  
        
        if(line.match("ended"))
          match_data = Extractor::Match.new(line)
          self.match.update(end_date: match_data.end_date_to_datetime)
        end
      end
    end
  end
end