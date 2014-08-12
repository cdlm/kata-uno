module Uno

  class Player
    attr_reader :name, :hand

    def self.dealer()  @dealer ||= Dealer.new  end

    def initialize(name)
      @name = name
      @hand = 7
    end

    def to_s()  name  end
    def dealer?()  false  end

    def discard()  @hand -= 1  end
    def pick(n = 1)  @hand += n  end
  end

  class Dealer
    def name()  'dealer'  end
    def to_s()  ''  end
    def dealer?()  true  end
    def discard()  end
    def pick(_)  end
  end
end
