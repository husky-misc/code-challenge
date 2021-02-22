class Match::Parser::Start
  attr_reader :parser

  def initialize(line, parser=Match::Parser)
    @line   = line
    @parser = parser.new(@line)
  end

  def save
    ::Match.find_or_create_by(
      match_id: parser.id,
      start_date: parser.string_to_datetime
    )
  end
end