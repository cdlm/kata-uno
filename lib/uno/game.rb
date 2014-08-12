require 'uno/exceptions'

module Uno

  class Game
    attr_reader :involved

    def initialize
      @players = []
      @involved = []
      @dealer = Player.new nil
      @top_play = nil
    end

    def add_player(player)  @players << player  end

    def player(play)  @players.find { |p| play.from? p }  end
    def expected_player()  @players.first  end
    def current_player()  player @top_play  end

    def reveal(play)
      fail GameError.new(play) unless play.reveal?
      @players.unshift @dealer
      update play
      @players.delete @dealer
    end

    def play(play)
      fail WrongPlayer.new(play) unless play.from?(expected_player)
      fail WrongCard.new(play) unless play.accept?(@top_play)
      update play
    end

    def update(play)
      @involved = []
      @top_play = play # FIXME: wrong in the case of a draw
      play.pre_turn self
      pass
      play.post_turn self
    end

    def involve(player)
      @involved << player unless player == @dealer
    end

    def pass()  @players.rotate!  end
    def reverse()  @players.rotate!.reverse!  end

    def pick
      current_player.pick 1
      involve current_player
    end

    def penalize(n)
      expected_player.pick n
      involve expected_player
    end

    def discard
      current_player.discard
      involve current_player
    end
  end
end
