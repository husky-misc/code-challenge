module Matches
  class TopPresenter
    include Rails.application.routes.url_helpers

    def initialize(players)
      @players = players
    end

    def attributes
      data = []

      players.each_with_index do |player, index|
        data << {
          nickname: player.nickname,
          position: (index + 1)
        }
      end

      data
    end

    private

    attr_reader :players
  end
end
