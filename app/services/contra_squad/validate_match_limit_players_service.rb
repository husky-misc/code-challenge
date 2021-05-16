module ContraSquad
  class ValidateMatchLimitPlayersService
    def initialize(file_content, modality = :combat)
      @file_content = file_content.split("\n").uniq
      @modality = modality
      @response = { result: '', errors: [] }
    end

    def call
      players_amount = extract_uniq_player_names.length

      valid_players_amount?(players_amount)
      even_players_amount?(players_amount) if @modality == :team

      @response[:result] = :valid if @response[:errors].blank?

      @response
    end

    private

    def valid_players_amount?(players_amount)
      return if players_amount >= 2 && players_amount <= 20

      @response[:errors].append('Some match exceeded the limit of players (2 - 20)')
    end

    def even_players_amount?(players_amount)
      return if players_amount.even?

      @response[:errors].append('Some match players amount is not even!')
    end

    def extract_uniq_player_names
      parsed_file_content = @file_content.map.with_index do |combat_line, index|
        extract_combat_players(combat_line) if inside_match_scope?(index, @file_content.length)
      end

      parsed_file_content.compact.flatten.uniq
    end

    def extract_combat_players(combat_line)
      date, combat = combat_line.split(' - ')

      return unless date && combat

      combat = combat.split.join(' ').gsub('killed', '').gsub('using', '').split

      [combat[0], combat[1]]
    end

    def inside_match_scope?(index, length)
      index.positive? && index < length - 1
    end
  end
end
