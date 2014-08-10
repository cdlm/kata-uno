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

    def increment()  1  end

    def update(game)
      # TODO: should be redefined in subclasses
      case value
      when 'reverse' then game.reverse_direction
      end
    end
  end

end
