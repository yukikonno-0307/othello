require './board.rb'
require './player.rb'

class Operator
  attr_accessor :board
  def initialize
    @board = Board.new(9, 9)
    @players = {
      true => Player.new(true),
      false => Player.new(false)
    }
    @turn = true
  end

  def start
    until @board.gameset? do
      @players[@turn].put(@board)
      @board.show
      @turn = !@turn
    end
  end
end

op = Operator.new
op.start
#op.board.gameset?
