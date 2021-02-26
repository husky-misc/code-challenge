module Plays
  class CreateService
    include ActiveModel::Validations
    validates :match, :killer, :victim, :weapon, :gametime, presence: true

    def initialize(match:, killer:, victim:, weapon:, gametime:)
      @match = match
      @killer = killer
      @victim = victim
      @weapon = weapon
      @gametime = gametime
    end

    def call
      raise_validation_error if invalid?

      Play.create!(
        match: match,
        killer: killer,
        victim: victim,
        weapon: weapon,
        gametime: gametime
      )
    end

    private

    attr_reader :match, :killer, :victim, :weapon, :gametime
  end
end
