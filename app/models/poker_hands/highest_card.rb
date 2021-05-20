# frozen_string_literal: true

module PokerHands
  class HighestCard < PokerHand
    def self.possible?(deck_by_face, deck_by_suit)
      true
    end

    def self.to_s
      'highest-card'
    end
  end
end
