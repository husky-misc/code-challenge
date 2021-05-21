# frozen_string_literal: true

class GameAnalyzer < ApplicationService
  class NoContentFile < StandardError
    def message
      I18n.t('.no_content_file')
    end
  end

  def initialize(games_file)
    @games_file = games_file
  end

  def call
    raise NoContentFile if File.empty?(@games_file)

    result = []

    File.foreach(@games_file) do |line|
      hand = Hand.build(line)
      result << HandEvaluator.call(hand)
    rescue StandardError => e
      result << { line: line, errors: e.message }
    end

    result
  end
end
