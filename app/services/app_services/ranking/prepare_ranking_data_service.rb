module AppServices
  module Ranking
    # Responsible to prepare ranking data. ::AppServices::Ranking::PrepareRankingDataService

    class PrepareRankingDataService
      def initialize(current_match_content)
        @current_match_content = current_match_content
      end

      def call
        preparing_steps_methods.map { |step_method| send(step_method) }

        @current_match_content
      end

      private

      def preparing_steps_methods
        %i[
          extract_counts_data
          extract_undead_players
          extract_fivefold_death_players
          extract_highest_frags_sequence
        ]
      end

      def extract_counts_data
        frags, deaths, weapons = append_counts_data([], [], [])

        @current_match_content += [{
          frags: split_flags_by_world_player(count_items(frags)),
          deaths: count_items(deaths),
          weapons: count_weapons(weapons)
        }]
      end

      def split_flags_by_world_player(counted_frags)
        without_world_player = {
          totality: counted_frags[:totality] - (counted_frags[:content]['<WORLD>'] || 0),
          content: counted_frags[:content].dup.except!('<WORLD>')
        }

        { with_world_player: counted_frags, without_world_player: without_world_player }
      end

      def append_counts_data(frags, deaths, weapons)
        @current_match_content.map do |content_line|
          if combat_line?(content_line[:log_item])
            killer, death_information = content_line[:log_item].split('killed')

            frags.append(killer&.strip)
            deaths.append(deaths_from_death_information(death_information))
            weapons.append(weapons_from_death_information(death_information))
          end

          content_line
        end

        [frags, deaths, weapons]
      end

      def combat_line?(line)
        line.downcase.include?('killed')
      end

      def deaths_from_death_information(death_information)
        killed = death_information.split('by')[0] if death_information.include?('by')
        killed = death_information.split('using')[0] if death_information.include?('using')

        killed&.strip
      end

      def weapons_from_death_information(death_information)
        used_weapon = death_information.split('by')[1] if death_information.include?('by')
        used_weapon = death_information.split('using')[1] if death_information.include?('using')

        used_weapon&.strip
      end

      def count_items(items)
        totality = 0

        content = items.each_with_object({}) do |item, counter|
          totality += 1
          counter[item] ||= 0
          counter[item]  += 1
        end

        { content: content, totality: totality }
      end

      def count_weapons(weapons)
        weapons.each_with_object({}) do |weapon, counter|
          counter[weapon] ||= 0
          counter[weapon]  += 1
        end
      end

      def extract_undead_players
        combat_data = @current_match_content.last

        undead_players = combat_data[:frags][:with_world_player][:content].keys -
                         combat_data[:deaths][:content].keys

        @current_match_content += [{ undead_players: undead_players }]
      end

      def extract_fivefold_death_players
        frags_content = @current_match_content.second_to_last[:frags][:with_world_player][:content]

        fivefold_death_players = frags_content.map do |player|
          player[1] == 1 ? { name: player[0], frags: player[1] } : nil
        end

        @current_match_content += [{ fivefold_death_players: fivefold_death_players.compact }]
      end

      def extract_highest_frags_sequence
        undead_players, all_frags = bring_undeads_and_flags

        return false unless undead_players.present? && all_frags.present?

        frags_sequence = all_frags.map do |frag|
          undead_players.include?(frag[0]) ? { name: frag[0], frags: frag[1] } : nil
        end

        highest_frag_sequences = frags_sequence.compact.max_by(frags_sequence.length) do |sequence|
          sequence[:frags]
        end

        @current_match_content += [{ highest_frag_sequences: highest_frag_sequences }]
      end

      def bring_undeads_and_flags
        undead_players = @current_match_content.second_to_last[:undead_players]
        all_frags = @current_match_content.third_to_last[:frags][:with_world_player][:content]

        [undead_players, all_frags]
      end
    end
  end
end
