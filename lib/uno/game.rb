require 'uno'

module Uno

  class Game
    attr_accessor :players

    def initialize
      @players = []
      @direction = 1
      @current_play = nil
    end

    def add_player(player)
      @players << player
    end

    def reveal(play)
      fail unless play.reveal?
      @current_play = play
    end

    def play(play)
      fail unless @current_play.accept?(play)
      play.update self
      @current_play = play
    end

    def expected_player
      @current_play.next_player @direction, @players
    end

    def reverse_direction
      @direction = -@direction
    end

  end
end