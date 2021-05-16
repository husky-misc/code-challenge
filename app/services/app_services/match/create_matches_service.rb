module AppServices
  module Match
    # Responsible to create matches from file. ::AppServices::Match::CreateMatchesService

    class CreateMatchesService
      def initialize(ranking_id, log_file)
        @log_file = log_file
        @ranking_id = ranking_id

        @response = { result: '', errors: [] }
      end

      def call
        try_create_matches

        @response
      end

      private

      def try_create_matches
        @response[:result] = @log_file.strip.split(' has ended').map do |match|
          ::Match.create!(extract_data_to_create(match))
        end
      rescue StandardError => _e
        @response[:errors].append('Something went wrong creating matches!')
      end

      def extract_data_to_create(match)
        splitted_match = match.split

        started_at = "#{splitted_match[0]} #{splitted_match[1]}"
        ended_at = "#{splitted_match[-5]} #{splitted_match[-4]}"
        content = extract_match_content(match)

        { match_code: splitted_match.last, ranking_id: @ranking_id, started_at: started_at,
          ended_at: ended_at, content: content.to_json,
          frags: extract_frags(content) }
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

      def extract_frags(match_content)
        match_content.to_s.downcase.split('killed').size - 1
      end
    end
  end
end
