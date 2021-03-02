# frozen_string_literal: true

class StoreMatchService < ApplicationService
  def initialize(game)
    @game = game
  end

  def call
    matches = Games::Logs::Matches::Extract.new(game).all_matches
    matches.each do |match|
      match_data = Games::Logs::Matches::Data.new(match)
      next unless match_data.valid_match?

      game.matches.create(
        match_id: match_data.id,
        ranking: match_data.ranking.to_json,
        started_at: match_data.started_at,
        finished_at: match_data.finished_at
      )
    end
  end

  attr_reader :game
end
