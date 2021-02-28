# frozen_string_literal: true

class Games::Logs::Matches::Extract
  def initialize(game)
    @file = game.file
    @filepath = ActiveStorage::Blob.service.path_for(@file.key)
    @matches = File.read(filepath).split(/^\s/)
  end

  def all_matches
    matches.each_with_object([]) do |match, array|
      array << extract_match_events(match)
    end
  end

  private

  EVENT_REGEX = /(^\d.+\d) - (.+)/

  def extract_match_events(match)
    match.split(/\n/).each_with_object([]) do |m, array|
      datetime, event = m.match(EVENT_REGEX).captures
      array << { datetime: datetime, event: event }
    end
  end

  attr_reader :file, :filepath, :matches
end
