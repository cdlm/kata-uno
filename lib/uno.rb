module Uno
  class FormatError < StandardError
    attr_reader :lineno, :line
    def initialize(lineno, line)  @lineno, @line = lineno, line  end
    def to_s()  "#{lineno}: format error\n#{line}"  end
  end
end

require 'uno/checker'
