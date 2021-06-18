
class Board
  attr_accessor :cell_data
  def initialize(x_line_size, y_line_size)
    @x_line_size = x_line_size
    @y_line_size = y_line_size
    @x_sep_char = '|'
    @cell_data = Hash.new {|h,k| h[k] = Hash.new(' ')}
  end

  def show
    puts get_x_line_header
    @y_line_size.times do |y|
      puts get_line y+1
    end
  end

  def set(x, y, piece)
    @cell_data[x][y] = piece
  end

  def full?
    board_statuses = Array.new
    (1..@x_line_size).each do |x|
      (1..@y_line_size).each do |y|
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

  def get_x_line_header
    Array.new(@x_line_size){|x|x+1}.insert(0, ' ').join(sep=@x_sep_char)
  end

  def get_line(y_cursor)
    Array.new(@x_line_size){|x_cursor|@cell_data[x_cursor+1][y_cursor]}.insert(0, y_cursor).join(sep=@x_sep_char)
  end

  def search(p, axis_cursor, put_position, mode)
    found_pieces = Array.new
    (1..(mode == 'x'? @x_line_size : @y_line_size)).each do |cursor|
      fetched_data = mode == 'x'? @cell_data[cursor][axis_cursor] : @cell_data[axis_cursor][cursor]
      found_pieces << cursor if fetched_data == p
    end
    axis_position_index = found_pieces.find_index(put_position)
    from_position = axis_position_index != 0? found_pieces[axis_position_index-1] : axis_position_index
    to_position = axis_position_index != found_pieces.length-1? found_pieces[axis_position_index+1] : axis_position_index
    [from_position, to_position]
  end
end

=begin
def test_reverse
  b = Board.new(9, 9)
  (1..9).each do |i|
    next if i == 5
    b.set(i, 5, i.odd?? '●' : '○')
    b.set(5, i, i.odd?? '●' : '○')
  end
  b.set(5, 5, '●')
  b.reverse(5, 5, '●')

  b.show
end

test_reverse
=end
