require 'uno/exceptions'

module Uno

  class Game
    attr_reader :involved, :current_player, :dealer

    def initialize
      @players = []
      @involved = []
      @dealer = Player.dealer
      @top_play = nil
    end

    def add_player(player)  @players << player  end

    def player(name)
      found = @players.find { |p| p.name == name }
      fail UnknownPlayer.new(name) unless found
      found
    end

    def expected_player()  @players.first  end

    def winner?()  !winner.nil?  end
    def winner()  @players.find { |p| p.hand <= 0 }  end

    def reveal(play)
      fail GameError.new(play) unless play.reveal?
      @players.unshift @dealer
      play play
      @players.delete @dealer
    end

    def play(play)
      @involved = []
      validate(play)
      @current_player = play.player
      @top_play = play.over(@top_play)
      play.pre_turn self
      pass unless @top_play.twin?
      play.post_turn self
    end

    def validate(play)
      play.check_twin(@top_play)
      unless play.from?(expected_player) || play.twin?
        fail WrongPlayer.new(play)
      end
      fail WrongCard.new(play) unless play.accept?(@top_play)
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

    private

    def involve(player)
      @involved << player unless player == @dealer
    end
  end
end
