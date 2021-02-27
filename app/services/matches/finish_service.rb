module Matches
  class FinishService
    include ActiveModel::Validations
    validates :match, :finish, presence: true

    def initialize(match, finish)
      @match = match
      @finish = finish
    end

    def call
      raise_validation_error if invalid?

      match.finish = finish

      match.save

      match
    end

    private

    attr_reader :match, :finish
  end
end
