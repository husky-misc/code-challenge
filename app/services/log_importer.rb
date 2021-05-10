class LogImporter
  attr_reader :data
  attr_accessor :errors, :parsed_data, :last_created_match

  class NoParsedData < StandardError; end

  def initialize(raw_data)
    @data = raw_data.split("\n")
    @errors = []
    @last_created_match = nil
  end

  def valid?
    errors.empty?
  end

  def parse_data
    line_number = 0

    @parsed_data =
      data.inject([]) do |acc, line|
        line_number += 1

        parsed_line = parse_line(line, line_number)

        acc.push(parsed_line)
      end
  end

  def save!
    if parsed_data.empty?
      raise NoParsedData, "there is no data to be saved"
    end

    ActiveRecord::Base.transaction do
      parsed_data.each do |row|
        action = row[:action]
        result = row[:result]

        case action
        when :new_match
          @last_created_match = Match.create!(started_at: result[:timestamp], external_id: result[:match_id])
        when :end_match
          @last_created_match.update!(finished_at: result[:timestamp])
        when :killed_by_player
          killer_player_nickname = result[:killer_player_nickname]
          dead_player_nickname = result[:dead_player_nickname]

          save_kill_round_action!(killer_player_nickname, dead_player_nickname, last_created_match)
        when :killed_by_world
          Player.find_or_create_by!(nickname: result[:dead_player_nickname])
        end
      end
    end
  end

  private

  def save_kill_round_action!(killer_player_nickname, dead_player_nickname, match)
    players = {
      killer_player_nickname: Player.find_or_create_by!(nickname: killer_player_nickname),
      dead_player_nickname: Player.find_or_create_by!(nickname: dead_player_nickname)
    }

    Round.create!(
      action: :kill,
      metadata: {
        killer_player_nickname: killer_player_nickname,
        dead_player_nickname: dead_player_nickname
      },
      match: match
    )

    match.inc_frags_count()
  end

  def parse_line(line, line_number)
    result = nil

    validators().each do |action, validator|
      if match_data = line.match(validator)
        result = {action: action, result: match_data}
        break
      end
    end

    return result if result.present?

    errors.push "Invalid data on line #{line_number}"
  end

  def validators
    {
      new_match: /(?<timestamp>.*) - New match (?<match_id>\d+)/,
      end_match: /(?<timestamp>.*) - Match (?<match_id>\d+) has ended/,
      killed_by_player: /(?<timestamp>.*) - (?<killer_player_nickname>.*) killed (?<dead_player_nickname>.*) using (?<gun>.*)/,
      killed_by_world: /(?<timestamp>.*) - (?<killer_player_nickname><WORLD>) killed (?<dead_player_nickname>.*) by (?<gun>.*)/,
    }
  end
end
