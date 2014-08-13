module Uno

  class FormatError < StandardError
    attr_reader :lineno, :text
    def initialize(lineno, text)  @lineno, @text = lineno, text  end
    def to_s()  "format error line #{lineno}: \"#{text.chomp}\""  end
  end

  class GameError < StandardError; end

  class UnknownPlayer < GameError
    attr_reader :name
    def initialize(name)  @name = name  end
    def to_s()  "unknown player \"#{name}\""  end
  end

  class WrongPlay
    attr_reader :play
    def initialize(play)  @play = play  end
    def to_s()  "wrong play \"#{play}\""  end
  end

  class WrongCard < GameError
    def to_s()  'wrong card'  end
  end

  class WrongPlayer < GameError
    def to_s()  'wrong player'  end
  end
end
