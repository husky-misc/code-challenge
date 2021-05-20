# frozen_string_literal: true

module PokerHands
  class FourOfAKind < PokerHand
    def self.possible?(deck_by_face, deck_by_suit)
      true
    end

    def self.to_s
      'four-of-a-kind'
    end
  end
end
