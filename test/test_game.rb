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
      @game.reveal Play.new(5, 'red')
    end

    it 'should have a correct first player after reveal' do
      @game.expected_player.must_be_same_as @a
    end

    it 'should have a correct second player' do
      @game.play Play.new(6, 'red', 'A')
      @game.expected_player.must_be_same_as @b
    end

    it 'should come back to first player in 3 plays' do
      @game.play Play.new(6, 'red', 'A')
      @game.play Play.new(7, 'red', 'B')
      @game.play Play.new(8, 'red', 'C')

      @game.expected_player.must_be_same_as @a
    end

  end
end
