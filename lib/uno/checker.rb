require 'uno/player'
require 'uno/play'

module Uno

  COMMENT_RE = /^\s*(\#.*)$/
  VALUE_RE = /(\d|\+2|skip|reverse|joker|\+4)/
  COLOR_RE = /(red|green|blue|yellow)/
  CARD_RE = /#{VALUE_RE}\s+#{COLOR_RE}/

  class Checker

    def initialize(input, output)
      @lines = input.each_line.with_index.lazy.reject { |line, _| line.match COMMENT_RE }
      @output = output
      @players = []
      @direction = 1
    end

    def add_player(name)
      @players << Player.new(name)
      @output.puts name
    end

    def check
      parse_preamble
      @lines.each do |line, index|
        play = read_play line
        @output.puts play
        begin
          @current_play.accept? play
          play.update self # FIXME: refactor the game state out of this class
        rescue UnoException => e
          @output.puts "\# #{e}"
        end
      end
    end

    def parse_preamble
      @num_players = read_players_number @lines.next.first
      @output.puts "#{@num_players} players"

      @num_players.times do
        name = read_player_name @lines.next.first
        add_player name
      end

      @current_play = read_play @lines.next.first
      @output.puts @current_play
    end

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

    def read_play(line)
      line.match(/^\s*(#{CARD_RE}|draw)\s+(\w+)?/) do |match|
        value, color, player_name = match[2], match[3], match[4]
        player = player_name && @players.find { |p| p.name == player_name }
        # TODO: handle draw
        Play.new(value, color, player)
      end
    end

  end
end
