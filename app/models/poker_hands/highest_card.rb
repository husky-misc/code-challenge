# frozen_string_literal: true

module PokerHands
  class HighestCard < PokerHand
    def self.possible?(*args)
      true
    end

    def self.to_s
      'highest-card'
    end
  end
end
