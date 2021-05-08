module AppServices
  module Log
    # Responsible to get file modality (combat or team). ::AppServices::Log::ExtractModalityService

    class ExtractModalityService
      def initialize(log_file)
        @log_file = log_file
        @response = :combat
      end

      def call
        @response = :team if team_modality?

        @response
      end

      private

      def team_modality?
        extract_first_combat_line.include?('light') || extract_first_combat_line.include?('dark')
      end

      def extract_first_combat_line
        @log_file.split("\n")[1].split('-')[1].downcase
      end
    end
  end
end
