require './board.rb'
require './piece.rb'

def test_upper_left_reverse_position(b)
  b.set(3, 3, Piece.new(false))
  b.set(2, 2, Piece.new(true))
  b.set(1,1,Piece.new(false))
  b.show
  b.cells[6][6].put(b, Piece.new(false))
  pp b.positions
  b.show
end

b = Board.new(8, 8)
test_upper_left_reverse_position(b)
