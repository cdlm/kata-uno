module Uno

  class Play
    attr_reader :value, :color, :player

    def initialize(value, color, player)
      @value, @color, @player = value, color, player
    end

    def to_s()  "#{value} #{color} #{player}"  end
  end
end
