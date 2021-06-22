require './cell.rb'
require './piece.rb'
require './reverse_positions.rb'

class Board
  attr_reader :min_limits, :max_limits
  attr_accessor :cell_data, :cells, :positions
  def initialize(x_size, y_size)
    @x_size = x_size; @y_size = y_size
    @x_sep_char = '|'
    @min_limits = [0, 1]; @max_limits = [x_size, x_size - 1]
    #@cell_data = Hash.new {|h,k| h[k] = Hash.new {|h,k| h[k] = Cell.new}}
    @cells = Hash.new {|h,k| h[k] = {}}
    @positions = ReversePosition.new
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

  def set(x, y, piece)
    @cells[x][y].piece = piece
  end

  def full?
    board_statuses = Array.new
    (1..@x_size).each do |x|
      (1..@y_size).each do |y|
        board_statuses << @cell_data[x][y].instance_of?(Piece)
      end
    end
    board_statuses.all?
  end

  def reverse(x, y, p)
    x_founds = search(p, y, x, 'x')
    (x_founds[0]..x_founds[1]).each do |x_cursor|
      @cell_data[x_cursor][y] = p
    end
    y_founds = search(p, x, y, 'y')
    (y_founds[0]..y_founds[1]).each do |y_cursor|
      @cell_data[x][y_cursor] = p
    end
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
end

=begin
  def search(p, axis_cursor, put_position, mode)
    found_pieces = Array.new
    (1..(mode == 'x'? @x_size : @y_size)).each do |cursor|
      fetched_data = mode == 'x'? @cell_data[cursor][axis_cursor] : @cell_data[axis_cursor][cursor]
      found_pieces << cursor if fetched_data == p
    end
    axis_position_index = found_pieces.find_index(put_position)
    from_position = axis_position_index != 0? found_pieces[axis_position_index-1] : axis_position_index
    to_position = axis_position_index != found_pieces.length-1? found_pieces[axis_position_index+1] : axis_position_index
    [from_position, to_position]
  end
end
=end
