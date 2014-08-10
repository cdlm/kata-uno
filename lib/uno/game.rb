require 'uno/exceptions'

module Uno

  class Game
    def initialize
      @players = []
      @direction = 1
      @current_play = nil
    end

    def add_player(player)
      @players << player
    end

    def reveal(play)
      fail GameError.new(play) unless play.reveal?
      play.update self
      @current_play = play
    end

    def play(play)
      fail WrongPlayer.new(play) unless play.from?(expected_player)
      fail WrongCard.new(play) unless play.accept?(@current_play)
      play.update self
      @current_play = play
    end

    def expected_player
      current = if @current_play.reveal?
                  { 1 => -1, -1 => 0 }[@direction]
                else
                  @players.index { |p| @current_play.from? p }
                end
      following = (current + @direction * @current_play.increment).modulo(@players.size)
      @players[following]
    end

    def reverse_direction
      @direction = -@direction
    end

  end
end
