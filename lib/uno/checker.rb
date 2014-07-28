require 'uno/player'

module Uno
  class Checker

    def initialize(input, output)
      @input, @lines, @output = input, input.each_line, output
      parse_preamble
    end

    def parse_preamble
      line = skip_comments @lines
      num_players = read_players_number line

      @players = Array.new(num_players) do
        line = skip_comments @lines
        name = read_player_name line
        Player.new name
      end
    end

    def skip_comments(lines)  lines.find { |l| not l.start_with?('#') }  end

    def read_players_number(line)
      match = line.match(/^\s*(\d+) players\s*$/)
      fail FormatError.new(input.lineno, line) if match.nil?
      match[1].to_i
    end

    def read_player_name(line)
      match = line.match(/^\s*(\S+)\s*$/)
      fail FormatError.new(input.lineno, line) if match.nil?
      match[1]
    end

    def check_all
    end

  end
end
