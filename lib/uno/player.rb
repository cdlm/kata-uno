module Uno

  class Player
    attr_reader :name, :hand

    def initialize(name)
      @name = name
      @hand = 7
    end

    def discard
      @hand -= 1
    end
  end
end
