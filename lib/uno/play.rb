module Uno

  class Play
    attr_reader :value, :color, :player

    def initialize(value, color, player)
      @value, @color, @player = value, color, player
    end

    def to_s()  "#{value} #{color} #{player}"  end

    def accept?(other)
      color == other.color || value == other.value
    end

    def update(game)
      # TODO: should be redefined in subclasses
    end
  end
end
