class MatchRecorderService
  def initialize(file)
    @file = file
    @match = nil
  end

  def call
    File.readlines(file).each do |line|
      time, data = line.split(' - ')

      next if corrupted_or_empty_line?(time, data)

      time = time.to_time
      data = data.strip

      case data
      when ->(str) { str.match?(/New match (.*?) has started/) }
        match_id = data.match(/New match (.*?) has started/)[1]
        @match = create_a_match!(match_id, time, file)
      when ->(str) { str.match?(/Match (.*?) has ended/) }
        finish_a_match!(@match, time)
      when ->(str) { str.match?(/(.*?) killed (.*?) using (.*)/) }
        event_data = data.match(/(.*?) killed (.*?) using (.*)/)

        killer = killer(event_data[1])
        victim = victim(event_data[2])
        weapon = weapon(event_data[3])

        create_a_play!(@match, killer, victim, weapon, time)
      when ->(str) { str.match?(/<WORLD> killed (.*?) by DROWN/) }
        event_data = data.match(/<WORLD> killed (.*?) by DROWN/)
        victim = victim(event_data[1])

        create_a_world_death!(@match, victim, time)
      end
    end
  end

  private

  attr_reader :file
  attr_accessor :match

  def corrupted_or_empty_line?(time, data)
    return true if time.blank? || data.blank?

    false
  end

  def create_a_match!(match_id, start, file)
    Matches::StartService.new(match_id, start, file).call
  end

  def finish_a_match!(match, finish)
    file.rewind
    Matches::FinishService.new(match, finish).call
  end

  def killer(nickname)
    Players::FindOrCreateService.new(nickname).call
  end

  def victim(nickname)
    Players::FindOrCreateService.new(nickname).call
  end

  def weapon(name)
    Weapons::FindOrCreateService.new(name).call
  end

  def create_a_play!(match, killer, victim, weapon, gametime)
    Plays::CreateService.new(
      match: match,
      killer: killer,
      victim: victim,
      weapon: weapon,
      gametime: gametime
    ).call
  end

  def create_a_world_death!(match, victim, gametime)
    Plays::CreateService.new(
      match: match,
      killer: nil,
      victim: victim,
      weapon: nil,
      gametime: gametime
    ).call
  end
end
