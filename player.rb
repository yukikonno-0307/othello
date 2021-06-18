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
