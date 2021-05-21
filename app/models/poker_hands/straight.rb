# frozen_string_literal: true

module PokerHands
  class Straight < PokerHand
    def self.possible?(combination)
      faces = combination[:sorted].map(&:face).uniq

      five_consecutives?(faces)
    end

    def self.to_s
      'straight'
    end
  end
end
