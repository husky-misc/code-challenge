class Match::Parser::Finish
  attr_reader :parser

  def initialize(line, parser=Match::Parser)
    @line   = line
    @parser = parser.new(@line)
  end

  def save
      match = ::Match.where(match_id: parser.id).first
      match.update(end_date: parser.string_to_datetime)
  end
end