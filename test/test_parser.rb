require_relative 'helper'
require 'uno/checker'

describe 'the input file parser' do

  before do
    input, output = '', nil
    @player = Player.new('Paul')
    game = Game.new
    game.add_player @player
    @parser = Uno::Checker.new game, input, output
  end

  it 'should parse a number card' do
    line = '7  red   Paul'
    play = @parser.read_play line, 42
    play.value.must_equal '7'
    play.color.must_equal 'red'
    play.player.must_be_same_as @player
    play.to_s.must_equal '7 red Paul'
  end

  it 'should parse a draw' do
    line = 'draw Paul'
    play = @parser.read_play line, 42
    play.player.must_be_same_as @player
    play.to_s.must_equal 'draw Paul'
  end

  it 'should parse the number of players' do
    line = ' 3   players '
    n = @parser.read_players_number line, 42
    n.must_equal 3
  end

  it 'should parse a player name' do
    line = ' Paul  '
    name = @parser.read_player_name line, 42
    name.must_equal 'Paul'
  end
end
