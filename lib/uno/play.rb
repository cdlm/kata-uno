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

    def from?(player)
      player_name == player.name
    end

    def increment
      value == 'skip'  ?  2  :  1
    end

    def update(game)
      case value
      when 'reverse' then game.reverse_direction
      end
      game.discard self
    end
  end
end
