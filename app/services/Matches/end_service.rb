module Matches
  class EndService
    include ActiveModel::Validations
    validates :match, :log_file, :match_end, presence: true

    def initialize(match, log_file, match_end)
      @match = match
      @log_file = log_file
      @match_end = match_end
    end

    def call
      raise_validation_error if invalid?

      match.match_end = match_end
      match.match_log.attach(
        io: log_file,
        filename: "#{match.match_id}-#{SecureRandom.hex(10)}"
      )

      match.save

      match
    end

    private

    attr_reader :match, :log_file, :match_end
  end
end
