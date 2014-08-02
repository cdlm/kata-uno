require_relative 'helper'
require 'uno/checker'

describe 'the input file parser' do

  before do
    input, output = '', nil
    @parser = Uno::Checker.new input, output
  end

  it 'should parse a number card' do
    line = '7 red Carol'
    play = @parser.read_play line, 42
    play.value.must_equal '7'
    play.color.must_equal 'red'
    play.player_name.must_equal 'Carol'
    play.to_s.must_equal line
  end

end
