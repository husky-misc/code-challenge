class Match::FileImporter < ApplicationService
  def initialize(file)
    @file_reader = Match::FileReader.new(file: file)
  end

  def call
    Match.transaction do
      @file_reader.each_match do |match|
        match.save!
      end
    end
  end
end
