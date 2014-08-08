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

  class WrongCard < GameError; end
  class WrongPlayer < GameError; end
end

require 'uno/checker'
