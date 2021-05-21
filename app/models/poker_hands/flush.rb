# frozen_string_literal: true

module PokerHands
  class Flush < PokerHand
    def self.possible?(combination)
      five_of_the_same(combination[:by_suit]).any?
    end
  end
end
