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

  it 'should have a correct first player after reveal' do
    @game.reveal Uno::Play.new(7, 'red')
    @game.expected_player.must_be_same_as @a
  end
end
