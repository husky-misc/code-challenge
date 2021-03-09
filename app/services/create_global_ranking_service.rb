# frozen_string_literal: true

class CreateGlobalRankingService < ApplicationService
  def call
    global_ranking.map do |player|
      OpenStruct.new(player)
    end
  end

  def global_ranking
    all_matches.group_by { |player| player['name'] }.transform_values do |player_rankings|
      player_rankings.inject do |hash, player_ranking|
        final_hash_merged = hash.except('award', 'weapon', 'streak')

        final_hash_merged.merge(player_ranking) do |hash_key, first_hash_value, second_hash_value|
          hash_key == 'name' ? first_hash_value : first_hash_value + second_hash_value
        end
      end
    end.values
  end

  def all_matches
    Match.select(:ranking).map { |m| JSON.parse(m.ranking) }.flatten
  end
end
