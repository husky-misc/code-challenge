class Stat < ApplicationRecord
  include ActiveModel::AttributeMethods
  has_many :log, foreign_key: 'match_id'

  def self.statistics
    logs = Log.all
    logs.each do |p|
      kill = 0
      death = 0
      if p.player1.present?
        Stat.create(
          player: p.player1,
          kills: kill + 1,
          death: death
        )
      end
      next unless p.player2.present?
      Stat.create(
        player: p.player2,
        kills: kill,
        death: death + 1
      )
    end
  end

  def self.kills_death
    roman_statistics = Stat.where(player: 'Roman')
    roman = {}
    roman_kills = 0
    roman_death = 0
    roman_statistics.each do |d|
      name = 'Roman'
      roman_kills += 1 if d.kills != 0
      roman_death += 1 if d.death != 0
      roman = { player: name, kills: roman_kills, death: roman_death }
    end

    marcus_statistics = Stat.where(player: 'Marcus')
    marcus = {}
    marcus_kills = 0
    marcus_death = 0
    marcus_statistics.each do |d|
      name = 'Marcus'
      marcus_kills += 1 if d.kills != 0
      marcus_death += 1 if d.death != 0
      marcus = { player: name, kills: marcus_kills, death: marcus_death }
    end

    nick_statistics = Stat.where(player: 'Nick')
    nick = {}
    nick_kills = 0
    nick_death = 0
    nick_statistics.each do |d|
      name = 'Nick'
      nick_kills += 1 if d.kills != 0
      nick_death += 1 if d.death != 0
      nick = { player: name, kills: nick_kills, death: nick_death }
    end
    # debugger
    [roman, nick, marcus]
  end
end
