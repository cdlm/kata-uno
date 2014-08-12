module Uno

  class FormatError < StandardError
    attr_reader :lineno, :line
    def initialize(lineno, line)  @lineno, @line = lineno, line  end
    def to_s()  "#{lineno}: format error\n#{line}"  end
  end

  class GameError < StandardError
    attr_reader :play
    def initialize(play)  @play = play  end
  end

  class UnknownPlayer < StandardError
    attr_reader :name
    def initialize(name)  @name = name  end
  end

  class WrongCard < GameError
    def diagnostic()  'wrong card'  end
  end

  class WrongPlayer < GameError
    def diagnostic()  'wrong player'  end
  end
end
