require './board.rb'
require './player.rb'

class Operator
  attr_accessor :board
  def initialize
    @board = Board.new(8, 8)
    @players = {
      true => Player.new('Player A.', true),
      false => Player.new('Player B', false)
    }
    @turn = true
  end

  def start
    until gameset? do
      @players[@turn].put(@board)
      @board.show
      @turn = !@turn
    end
  end

  private

  def gameset?
    @board.full?
  end
end
