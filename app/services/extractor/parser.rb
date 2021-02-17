module Extractor
  class Parser
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def read
      File.foreach(file.path, "\n\n") do |line|
        ExtractData.new(line).extract
      end
    end
  end
end