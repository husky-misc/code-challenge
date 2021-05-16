module AppServices
  module Player
    # Responsible to create players. ::AppServices::Player::CreatePlayersService

    class CreatePlayersService
      def initialize(matches)
        @matches = matches
        @current_match_content = {}
        @current_player = {}
        @player_weapons = {}
        @player_deads = {}
        @player_frags = {}
      end

      def call
        @matches.map do |match|
          current_match_content = JSON.parse(match[:content])
          current_match_content.shift
          current_match_content.pop

          @current_match_content = current_match_content

          try_create_players(match)
        end
      end

      private

      def try_create_players(match)
        init_players_object.map do |player|
          @current_player = player

          prepare_player_data

          persist_player(match)
        end
      rescue StandardError => _e
        @response[:errors].append("Some error occurred in match: #{match.match_code}")
      end

      def persist_player(match)
        @current_player[:match_id] = match.id

        ::Player.create!(@current_player)
      end

      def init_players_object
        players = []

        @current_match_content.map do |line|
          killer, kill_information = line['log_item'].split('killed')
          killed, weapon = extract_from_kill_information(kill_information)
          compute_killer_and_killed(killer&.strip, killed&.strip, players)
          compute_player_frag(killer&.strip)
          compute_player_dead(killed&.strip)
          compute_player_weapon(killed&.strip, weapon&.strip)
        end

        init_player_objects(players)
      end

      def compute_killer_and_killed(killer, killed, players)
        players.append(killer)
        players.append(killed)
      end

      def compute_player_frag(killer)
        @player_frags[killer] = 0 if @player_frags[killer].blank?
        @player_frags[killer] += 1
      end

      def compute_player_dead(killed)
        @player_deads[killed] = 0 if @player_deads[killed].blank?
        @player_deads[killed] += 1
      end

      def compute_player_weapon(killed, weapon)
        @player_weapons[killed] = [] if @player_weapons[killed].blank?
        @player_weapons[killed].append(weapon)
      end

      def init_player_objects(players)
        players.uniq.map { |player| initial_player_object(player) }
      end

      def initial_player_object(player)
        { name: player, frags: 0, deads: 0, awarded: false, strong_weapon: '',
          strong_killer: false, score: 0 }
      end

      def extract_from_kill_information(kill_information)
        killed, weapon = kill_information.split('by') if kill_information.include?('by')
        killed, weapon = kill_information.split('using') if kill_information.include?('using')

        [killed, weapon]
      end

      def prepare_player_data
        extract_frags
        extract_deads
        awarded?
        strong_killer?
        extract_strong_weapon
        extract_score
      end

      def extract_frags
        @current_player[:frags] = @player_frags[@current_player[:name]] || 0
      end

      def extract_deads
        @current_player[:deads] = @player_deads[@current_player[:name]] || 0
      end

      def awarded?
        @current_player[:awarded] = @current_player[:deads].zero?
      end

      def strong_killer?
        @current_player[:strong_killer] = @current_player[:frags] >= 5
      end

      def extract_strong_weapon
        return unless @player_weapons[@current_player[:name]] && @current_player[:frags] > 0

        weapon_counts = Hash.new(0)
        @player_weapons[@current_player[:name]].each { |weapon| weapon_counts[weapon] += 1 }
        @current_player[:strong_weapon] = weapon_counts.key(weapon_counts.values.max)
      end

      def extract_score
        @current_player[:score] = (@current_player[:frags] * 50) - (@current_player[:deads] * 50)
      end
    end
  end
end
