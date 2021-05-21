# frozen_string_literal: true

module PokerHands
  class HighestCard < PokerHand
    def self.possible?(*_args)
      true
    end
  end
end
