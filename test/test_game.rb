require_relative 'helper'
require 'uno/game'
require 'uno/play'

include Uno

describe 'a new game of 3 players' do
  before do
    @game = Game.new
    @a = Player.new 'A'
    @b = Player.new 'B'
    @c = Player.new 'C'
    @game.add_player @a
    @game.add_player @b
    @game.add_player @c
  end

  describe 'when the reveal is a number' do
    before do
      @reveal_color = 'red'
      @game.reveal Play.from(5, @reveal_color)
    end

    it 'should start with player 1' do
      @game.expected_player.must_be_same_as @a
    end

    it 'should have a correct second player' do
      @game.play Play.from(6, @reveal_color, 'A')
      @game.expected_player.must_be_same_as @b
    end

    it 'should come back to first player in 3 plays' do
      @game.play Play.from(6, @reveal_color, 'A')
      @game.play Play.from(7, @reveal_color, 'B')
      @game.play Play.from(8, @reveal_color, 'C')

      @game.expected_player.must_be_same_as @a
    end

    it 'should reject an incorrect color' do
      incorrect_number = Play.from(1, 'green', 'A')
      proc do
        @game.play incorrect_number
      end.must_raise WrongCard
    end

    it 'should reject the incorrect players' do
      %w(B C).each do |incorrect_name|
        proc do
          @game.play Play.from(1, @reveal_color, incorrect_name)
        end.must_raise WrongPlayer
      end
    end
  end

  describe 'when the reveal is a reverse' do
    before do
      @game.reveal Play.from('reverse', 'red')
    end

    it 'should start with last player' do
      @game.expected_player.must_be_same_as @c
    end

    it 'should continue with before-last player' do
      @game.play Play.from(7, 'red', 'C')
      @game.expected_player.must_be_same_as @b
    end
  end

  describe 'when the reveal is a skip' do
    before do
      @game.reveal Play.from('skip', 'red')
    end

    it 'should start with player 2' do
      @game.expected_player.must_be_same_as @b
    end

    it 'should continue with player 3' do
      @game.play Play.from(7, 'red', 'B')
      @game.expected_player.must_be_same_as @c
    end
  end

  describe 'when the reveal is a +2' do
    before do
      @game.reveal Play.from('+2', 'red')
    end

    it 'should start with player 2' do
      @game.expected_player.must_be_same_as @b
    end

    it 'should have made player 1 pick 2 cards' do
      @a.hand.must_equal 9
    end
  end
end
