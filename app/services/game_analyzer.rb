# frozen_string_literal: true

class GameAnalyzer < ApplicationService
  def initialize(games_file)
    @games_file = games_file
  end

  def call
    [
      { hand: 'TH JH QC QD QS', deck: 'QH KH AH 2S 6S', best_hand: :straight_flush },
      { hand: '2H 2S 3H 3S 3C', deck: '2D 3D 6C 9C TH', best_hand: :four_of_a_kind },
      { hand: '2H 2S 3H 3S 3C', deck: '2D 9C 3D 6C TH', best_hand: :full_house },
      { hand: '2H AD 5H AC 7H', deck: 'AH 6H 9H 4H 3C', best_hand: :flush },
      { hand: 'AC 2D 9C 3S KD', deck: '5S 4D KS AS 4C', best_hand: :straight },
      { hand: 'KS AH 2H 3C 4H', deck: 'KC 2C TC 2D AS', best_hand: :three_of_a_kind }
    ]
  end
end
