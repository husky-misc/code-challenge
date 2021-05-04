class LogImporter
  attr_reader :data
  attr_accessor :errors, :parsed_data

  def initialize(raw_data)
    @data = raw_data.split("\n")
    @errors = []
  end

  def valid?
    errors.empty?
  end

  def parse_data
    line_number = 0

    data.inject([]) do |acc, line|
      line_number += 1

      parsed_line = parse_line(line, line_number)

      acc.push(parsed_line, line_number)
    end
  end

  def save!
    
  end


  private

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
      kill: /(?<timestamp>.*) - (?<killer_player_id>.*) killed (?<dead_player_id>.*) using (?<gun>.*)/,
    }
  end

end
