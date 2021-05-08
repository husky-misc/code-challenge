module AppServices
  module Match
    # Responsible to extract matches data from file. ::AppServices::Match::ExtractMatchesDataService

    class ExtractMatchesDataService
      def initialize(log_file)
        @log_file = log_file

        @response = { result: '', errors: [] }
      end

      def call
        try_extract_matches

        @response
      end

      private

      def try_extract_matches
        @response[:result] = @log_file.strip.split(' has ended').map do |match|
          content = extract_match_content(match)

          { match_id: match.split.last, content: content }
        end
      rescue StandardError => _e
        @response[:errors].append('Something went wrong! Check if the file log is really correct.')
      end

      def extract_match_content(match)
        match_content = match.split("\n").map do |line_content|
          datetime, log_item = line_content.split('-')

          { datetime: prepare_datetime(datetime), log_item: prepare_log_item(log_item) }.compact
        end

        match_content.reject(&:empty?).each_with_index do |match_line, index|
          stripped_log_item = match_line[:log_item].downcase.strip

          append_invalid_match_format(stripped_log_item, index, match.strip.split("\n").length)

          match_line
        end
      end

      def prepare_datetime(datetime)
        datetime&.strip
      end

      def prepare_log_item(log_item)
        return unless log_item

        log_item.strip
        log_item += ' has ended' if log_item.split.length == 2
        log_item
      end

      def append_invalid_match_format(stripped_log_item, index, match_length)
        return if @response[:errors].present?
        return if index.zero? && stripped_log_item.include?('started')
        return if index == match_length - 1 && stripped_log_item.include?('ended')
        return if stripped_log_item.include?('killed')

        @response[:errors].append('Something went wrong! Some match has an invalid format!')
      end
    end
  end
end
