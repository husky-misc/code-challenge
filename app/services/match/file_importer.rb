class Match::FileImporter < ApplicationService
  def initialize(file)
    @file_reader = Match::FileReader.new(file: file)
  end

  def call
    Match.transaction do
      @file_reader.each_match do |match|
        Match::Creator.call(match)
      end
    end
  end
end
