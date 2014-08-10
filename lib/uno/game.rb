require 'uno/exceptions'

module Uno

  class Game
    def initialize
      @players = []
      @direction = 1
      @current_play = nil
    end

    def add_player(player)  @players << player  end

    def player_index(play)  @players.index { |p| play.from? p }  end
    def player(play)  @players.find { |p| play.from? p }  end
    def last_player()  player @current_play  end

    def reveal?()  @current_play.reveal?  end

    def reveal(play)
      fail GameError.new(play) unless play.reveal?
      play.update self
    end

    def play(play)
      fail WrongPlayer.new(play) unless play.from?(expected_player)
      fail WrongCard.new(play) unless play.accept?(@current_play)
      play.update self
    end

    def expected_player
      last = if @current_play.reveal?
               { 1 => -1, -1 => 0 }[@direction]
             else player_index @current_play
             end
      following = (last + @direction * @current_play.increment).modulo(@players.size)
      @players[following]
    end

    def reverse_direction()  @direction = -@direction  end

    def discard(play)
      player(play).discard unless play.reveal?
      @current_play = play
    end
  end
end
