class Frags::Parser::ByWorld
  attr_reader :line, :parser

  def initialize(line, match, parser = Frags::Parser)
    @line = line
    @parser = parser.new(line, match)
  end

  def save
    death
  end

  private

  def death
    ::Death.find_or_create_by(player: victim, gun: gun, match: parser.match, date: parser.string_to_datetime)
  end
  
  def gun
    ::Gun.find_or_create_by(name: parser.gun)
  end

  def victim
    ::Player.find_or_create_by(name: parser.victim)
  end
end