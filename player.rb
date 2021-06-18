require './piece.rb'

class Player
  def initialize(color_flg)
    @color_flg = color_flg
  end

  def put(board)
    x, y = gets.split(',').map(&:to_i)
    board.set(x, y, Piece.new(@color_flg))
  end
end

=begin
require './board.rb'

board = Board.new(9, 9)
player = Player.new(true)
board.show
player.put(board)
board.show
=end
