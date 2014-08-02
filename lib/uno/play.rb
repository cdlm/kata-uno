module Uno

  class Play
    attr_reader :value, :color, :player_name

    def initialize(value, color, player_name)
      @value, @color, @player_name = value, color, player_name
    end

    def to_s()  "#{value} #{color} #{player_name}".strip  end

    def accept?(other)
      color == other.color || value == other.value
    end

    def update(game)
      # TODO: should be redefined in subclasses
    end
  end
end
