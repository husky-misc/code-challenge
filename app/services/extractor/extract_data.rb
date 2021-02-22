class Extractor::ExtractData
  attr_reader :lines
  attr_accessor :match

  def initialize(line)
    @lines = line.split("\n")
  end

  def extract
    lines.map do |line|
      case line
      when /started/
        self.match = Match::Parser::Start.new(line).save
      when /ended/
        Match::Parser::Finish.new(line).save
      when /WORLD/
        Frags::Parser::ByWorld.new(line, match).save
      when /killed/
        Frags::Parser::ByPlayer.new(line, match).save
      end
    end
  end
end