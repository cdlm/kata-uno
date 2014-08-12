require_relative 'helper'
require 'uno/checker'

describe 'the input file parser' do

  before do
    input, output = '', nil
    @parser = Uno::Checker.new input, output
  end

  it 'should parse a number card' do
    line = '7  red   Carol'
    play = @parser.read_play line, 42
    play.value.must_equal '7'
    play.color.must_equal 'red'
    play.player_name.must_equal 'Carol'
    play.to_s.must_equal '7 red Carol'
  end

  it 'should parse a draw' do
    line = 'draw Bob'
    play = @parser.read_play line, 42
    play.player_name.must_equal 'Bob'
    play.to_s.must_equal 'draw Bob'
  end

  it 'should parse the number of players' do
    line = ' 3   players '
    n = @parser.read_players_number line, 42
    n.must_equal 3
  end

  it 'should parse a player name' do
    line = ' Alice  '
    name = @parser.read_player_name line, 42
    name.must_equal 'Alice'
  end
end
