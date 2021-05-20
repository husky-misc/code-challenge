# frozen_string_literal: true

module PokerHands
  class StraightFlush < PokerHand
    def self.possible?(deck_by_face, deck_by_suit)
      true
    end

    def self.to_s
      'straight-flush'
    end
  end
end
