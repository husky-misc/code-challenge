module Matches
  class StartService
    include ActiveModel::Validations
    validates :match_id, :match_begin, presence: true

    def initialize(match_id, match_begin)
      @match_id = match_id
      @match_begin = match_begin
    end

    def call
      raise_validation_error if invalid?

      Match.new(
        match_id: match_id,
        match_begin: match_begin
      )
    end

    private

    attr_reader :match_id, :match_begin
  end
end
