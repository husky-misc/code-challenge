module AppServices
  module Log
    # Responsible to validate an uploaded log file. ::AppServices::Log::ValidateLogFileService

    class ValidateLogFileService
      def initialize(log_file, game_mode)
        @log_file = log_file
        @game_mode = game_mode
        @response = { result: log_file, errors: [] }
      end

      def call
        @response[:modality] = ::AppServices::Log::ExtractModalityService.new(@log_file).call

        validate_content_block
        validate_limit_players

        @response
      end

      private

      def validate_limit_players
        dynamic_key_service = "#{@game_mode}_#{@response[:modality]}".to_sym

        limit_players_response = match_players_limit_services[dynamic_key_service].call

        @response[:errors] = @response[:errors] + limit_players_response[:errors]
      end

      def match_players_limit_services
        {
          contra_squad_combat: ::ContraSquad::ValidateMatchLimitPlayersService.new(@log_file),
          contra_squad_team: ::ContraSquad::ValidateMatchLimitPlayersService.new(@log_file, :team),
          # Not implemented
          classic_combat: ::ContraSquad::ValidateMatchLimitPlayersService.new(@log_file),
          # Not implemented
          classic_squad_team: ::ContraSquad::ValidateMatchLimitPlayersService.new(@log_file, :team)
        }
      end

      def validate_content_block
        splitted_log_file = @log_file.split

        return if valid_content_block?(splitted_log_file)

        @response[:errors].append('The match block provided is invalid!')
      end

      def valid_content_block?(content_block)
        content_block[3].casecmp('new').zero? && content_block.last.casecmp('ended').zero?
      end
    end
  end
end
