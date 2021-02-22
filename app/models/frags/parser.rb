class Frags::Parser
  DATE_FORMAT = /(\d+[\/]\d+[\/]\d+)/
  TIME_FORMAT = /(\d+[:]\d+[:]\d+)/

  attr_reader :line, :killed_index, :words, :match

  def initialize(line, match)
    @words = line.split(" ")
    @killed_index = @words.find_index("killed")
    @line = line
    @match = match
  end

  def string_to_datetime
    DateTime.parse("#{start_date} #{start_time}")
  end

  def killer
    words[killed_index - 1]
  end

  def victim
    words[killed_index + 1]
  end

  def gun
    words[killed_index + 3]
  end
  
  def start_date
    line.scan(DATE_FORMAT).flatten.first
  end

  def start_time
    line.scan(TIME_FORMAT).flatten.first
  end
end