require_relative 'helper'
require 'uno/game'
require 'uno/play'

describe 'a new game of 3 players' do

  before do
    @game = Uno::Game.new
    @a = Uno::Player.new 'A'
    @b = Uno::Player.new 'B'
    @c = Uno::Player.new 'C'
    @game.add_player @a
    @game.add_player @b
    @game.add_player @c
  end

  describe 'when the reveal is a number' do

    before do
      @game.reveal Uno::Play.new(5, 'red')
    end

    it 'should have a correct first player after reveal' do
      @game.expected_player.must_be_same_as @a
    end

    it 'should have a correct second player' do
      @game.play Uno::Play.new(6, 'red', 'A')
      @game.expected_player.must_be_same_as @b
    end

    it 'should come back to first player in 3 plays' do
      @game.play Uno::Play.new(6, 'red', 'A')
      @game.play Uno::Play.new(7, 'red', 'B')
      @game.play Uno::Play.new(8, 'red', 'C')

      @game.expected_player.must_be_same_as @a
    end

  end
end
