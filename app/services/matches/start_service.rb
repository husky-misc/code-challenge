module Matches
  class StartService
    include ActiveModel::Validations
    validates :match_id, :start, :log_file, presence: true

    def initialize(match_id, start, log_file)
      @match_id = match_id
      @start = start
      @log_file = log_file
    end

    def call
      raise_validation_error if invalid?

      match = Match.new(
        match_id: match_id,
        start: start
      )

      match.file.attach(
        io: log_file,
        filename: "#{match.match_id}-#{SecureRandom.hex(10)}"
      )

      match.save!

      match
    end

    private

    attr_reader :match_id, :start, :log_file
  end
end
