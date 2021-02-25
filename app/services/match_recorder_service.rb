class MatchRecorderService
  def initialize(file)
    @file = file
  end

  def call
    matches = []

    File.readlines(file).each do |line|
      time, data = line.split(' - ')

      next if corrupted_or_empty_line?(time, data)

      time = time.to_time
      data = data.strip

      case data
      when ->(str) { str.match?(/New match (.*?) has started/) }
        match_id = data.match(/New match (.*?) has started/)[1]

        matches << start_a_match!(match_id, time)

      when ->(str) { str.match?(/Match (.*?) has ended/) }
        match_id = data.match(/Match (.*?) has ended/)[1]

        the_match = matches.find do |match|
          match.match_id.eql?(match_id)
        end

        end_match!(the_match, file, time)
      end
    end

    matches
  end

  def start_a_match!(match_id, match_begin)
    Matches::StartService.new(
      match_id,
      match_begin
    ).call
  end

  def end_match!(match, file, match_end)
    file.rewind

    Matches::EndService.new(
      match,
      file,
      match_end
    ).call
  end

  def corrupted_or_empty_line?(time, data)
    return true if time.blank? || data.blank?

    false
  end

  private

  attr_reader :file
end
