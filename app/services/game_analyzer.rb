# frozen_string_literal: true

class GameAnalyzer < ApplicationService
  class NoContentFile < StandardError; end

  def initialize(games_file)
    @games_file = games_file
  end

  def call
    raise NoContentFile if File.empty?(@games_file)

    result = []

    File.foreach(@games_file) do |line|
      Rails.logger.debug("Reading line from file: #{line}")

      hand = Hand.build(line)
      result << HandEvaluator.call(hand)
    end

    result
  end
end
