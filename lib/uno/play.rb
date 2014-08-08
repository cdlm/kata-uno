module Uno

  class Play
    attr_reader :value, :color, :player_name

    def initialize(value, color, player_name = nil)
      @value, @color, @player_name = value, color, player_name
    end

    def to_s()  "#{value} #{color} #{player_name}".strip  end

    def reveal?()  player_name.nil?  end

    def accept?(other)
      color == other.color || value == other.value
    end

    def next_player(direction, players)
      return players.first if reveal?
      current = players.index { |p| p.name == player_name }
      (current + direction).modulo(players.size)
    end

    def update(game)
      # TODO: should be redefined in subclasses
    end
  end
end
