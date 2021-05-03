class Match::Builder
  def initialize
    @players = {}
    @weapons = {}
  end

  def build
    @match
  end

  def start_match(params)
    @match = Match.new(params)
    self
  end

  def create_kill(killed_at:, killer:, killed:, weapon:)
    killer_player = find_or_initialize_player(name: killer)
    killed_player = find_or_initialize_player(name: killed)
    weapon_used = find_or_initialize_weapon(name: weapon)
    @match.kills.build(killed_at: killed_at, killer: killer_player, killed: killed_player, weapon: weapon_used)
    self
  end

  def create_suicide(killed_at:, killed:)
    killed_player = find_or_initialize_player(name: killed)
    @match.kills.build(killed_at: killed_at, killed: killed_player)
    self
  end

  def end_match(ended_at:, code:)
    @match.ended_at = ended_at
    self
  end

  private

    def find_or_initialize_player(name:)
      @players[name] ||= Player.find_or_initialize_by(name: name)
    end

    def find_or_initialize_weapon(name:)
      @weapons[name] ||= Weapon.find_or_initialize_by(name: name)
    end
end
