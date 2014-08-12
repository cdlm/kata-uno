require 'abstract_method'

module Uno

  class Play
    attr_reader :player_name

    def self.from(value, color, name = nil) # rubocop:disable Style/CyclomaticComplexity
      case value
      when 'reverse' then Reverse.new color, name
      when 'skip' then Skip.new color, name
      when '+2' then PickTwo.new color, name
      when 'joker' then Joker.new name, color
      when '+4' then SuperJoker.new name, color
      else NumberPlay.new value, color, name
      end
    end

    def initialize(name)  @player_name = name  end
    def to_s()  "#{face} #{player_name}".strip  end

    def reveal?()  player_name.nil?  end
    def from?(player)  player_name == player.name  end

    abstract_method :face, :accept?, :pre_turn
    def post_turn(_)  end
  end

  class Draw < Play
    def face()  'draw'  end
    def accept?(_)  true  end

    def pre_turn(game)  game.pick  end
  end

  class ColoredPlay < Play
    attr_accessor :color

    def initialize(color, name)
      super(name)
      @color = color
    end

    def face()  "#{value} #{color}"  end
    abstract_method :value

    def accept?(other)  color == other.color  end
    def pre_turn(game)  game.discard  end
  end

  class NumberPlay < ColoredPlay
    attr_reader :value

    def initialize(value, color, name)
      super(color, name)
      @value = value
    end

    def accept?(other)
      super || other.is_a?(NumberPlay) && value == other.value
    end
  end

  class Reverse < ColoredPlay
    def value()  'reverse'  end

    def pre_turn(game)
      super(game)
      game.reverse
    end
  end

  class Skip < ColoredPlay
    def value()  'skip'  end
    def post_turn(game)  game.pass  end
  end

  class PickTwo < ColoredPlay
    def value()  '+2'  end

    def post_turn(game)
      game.penalize 2
      game.pass
    end
  end

  class Joker < ColoredPlay
    def value()  'joker'  end
    def accept?()  true  end
  end

  class SuperJoker < Joker
    def value()  '+4'  end

    def post_turn(game)
      game.penalize 4
      game.pass
    end
  end
end
