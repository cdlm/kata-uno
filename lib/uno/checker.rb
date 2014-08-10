require 'uno/exceptions'
require 'uno/game'
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
      @game = Game.new
    end

    def check
      parse_players
      parse_reveal
      show_status
      @lines.each do |line, index|
        play = read_play line, index
        echo play
        @game.play(play)
        show_status
      end
    end

    def show_status
      unless @game.reveal?
        last = @game.last_player
        annotate "#{last.name} #{last.hand} card#{last.hand > 1 ? 's' : ''} left"
      end
      annotate "#{@game.expected_player.name} to play"
    end

    def annotate(message)  @output.puts "# #{message}"  end
    def echo(line)  @output.puts line  end

    def parse_players
      num_players = read_players_number(*@lines.next)
      echo "#{num_players} players"

      num_players.times do
        name = read_player_name(*@lines.next)
        @game.add_player Player.new(name)
        echo name
      end
    end

    def parse_reveal
      reveal_play = read_play(*@lines.next)
      echo reveal_play
      @game.reveal reveal_play
    end

    def read_players_number(line, index)
      match = line.match(/^\s*(\d+)\s+players\s*$/)
      fail FormatError.new(index, line) if match.nil?
      match[1].to_i
    end

    def read_player_name(line, index)
      match = line.match(/^\s*(\S+)\s*$/)
      fail FormatError.new(index, line) if match.nil?
      match[1]
    end

    def read_play(line, index)
      match = line.match(/^\s*(#{CARD_RE}|draw)(?:\s+(\w+))?/)
      fail FormatError.new(index, line) if match.nil?

      value, color, player_name = match[2], match[3], match[4]
      # TODO: handle draw
      Play.new(value, color, player_name)
    end

  end
end
