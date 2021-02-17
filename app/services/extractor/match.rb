module Extractor
  class Match
    ID_FORMAT   = /\d+/
    DATE_FORMAT = /(\d+[\/]\d+[\/]\d+)/
    TIME_FORMAT = /(\d+[:]\d+[:]\d+)/
    
    attr_reader :line

    def initialize(line)
      @line = line
    end

    def id
      line.scan(ID_FORMAT).last
    end

    def start_date
      line.scan(DATE_FORMAT).flatten.first
    end

    def end_date
      line.scan(DATE_FORMAT).flatten.first
    end

    def start_time
      line.scan(DATE_FORMAT).flatten.first
    end

    def end_time
      line.scan(DATE_FORMAT).flatten.first
    end

    def to_s
      puts "#{id} - #{start_date} - #{end_date} - #{start_time} - #{end_time}"
    end
  end
end