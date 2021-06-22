require './cell.rb'
require './piece.rb'
require './reverse_positions.rb'

class Board
  attr_reader :min_limits, :max_limits
  attr_accessor :cells, :positions
  def initialize(x_size, y_size)
    @x_size = x_size; @y_size = y_size
    @x_sep_char = '|'
    @min_limits = [0, 1]; @max_limits = [x_size, x_size - 1]
    @cells = Hash.new {|h,k| h[k] = {}}
    @positions = ReversePositions.new
    initialize_cells
    put_init
  end

  def show
    puts get_x_line_header
    @y_size.times do |y|
      puts get_line y+1
    end
  end

  def set_force(x, y, piece)
    @cells[x][y].piece = piece
  end

  def put(x, y, piece)
    @cells[x][y].set_reverse_positions(self, piece)
    if @positions.presence?
      @cells[x][y].piece = piece
      reverse
      @positions.reset
    else
      @positions.reset
      return
    end
  end

  def full?
    board_statuses = []
    (1..@x_size).each do |x|
      (1..@y_size).each do |y|
        board_statuses << @cells[x][y].piece?
      end
    end
    board_statuses.all?
  end

  private

  def put_init
    set_force(4, 4, Piece.new(true))
    set_force(5, 4, Piece.new(false))
    set_force(5, 5, Piece.new(true))
    set_force(4, 5, Piece.new(false))
  end

  def initialize_cells
    (1..@x_size).each do |x|
      (1..@y_size).each do |y|
        @cells[x][y] = Cell.new(x, y)
      end
    end
  end

  def get_x_line_header
    Array.new(@x_size){|x|x+1}.insert(0, ' ').join(sep=@x_sep_char)
  end

  def get_line(y_cursor)
    Array.new(@x_size){|x_cursor|@cells[x_cursor+1][y_cursor]}.insert(0, y_cursor).join(sep=@x_sep_char)
  end

  def reverse
    @positions.iter_positions do |p|
      @cells[p[:x]][p[:y]].piece.reverse
    end
  end
end
