require './piece.rb'

class Player
  def initialize(name, color_flg)
    @name = name
    @color_flg = color_flg
  end

  def put(board)
    puts "#{@name}'s turn. Input 'x,y'."
    x, y = gets.split(',').map(&:to_i)
    board.set(x, y, Piece.new(@color_flg))
  end
end
