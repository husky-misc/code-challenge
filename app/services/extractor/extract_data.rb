module Extractor
  class ExtractData
    attr_reader :lines
    attr_accessor :match_id

    def initialize(line)
      @lines = line.split("\n")
    end

    def extract
      lines.map do |line|
        if (line.match("New match"))
          match_data = Extractor::Match.new(line)

          self.match = ::Match.create(
            match_id: match_data.id,
            start_date: match_data.start_date,
            end_date: match_data.end_date,
            start_time: match_data.start_time
            end_time: match_data.end_time
          )
        end        
      end
    end
  end
end