class Match::FileImporter
  def initialize(file:)
    @file_reader = Match::FileReader.new(file: file)
  end

  def import
    Match.transaction do
      @file_reader.each_match do |match|
        match.save
      end
    end
  end
end
