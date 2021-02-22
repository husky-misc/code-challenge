class Match::Parser
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

  def string_to_datetime
    DateTime.parse("#{date} #{time}")
  end

  def date
    line.scan(DATE_FORMAT).flatten.first
  end

  def time
    line.scan(TIME_FORMAT).flatten.first
  end
end