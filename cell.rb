
class Cell
  attr_reader :x, :y
  attr_accessor :piece
  def initialize(x, y)
    @x = x; @y = y
    @piece = nil
    @prev_x = x - 1; @next_x = x + 1
    @prev_y = y - 1; @next_y = y + 1
  end

  def piece?
    !@piece.nil?
  end

  def to_s
    @piece.nil? ? ' ' : @piece.to_s
  end

  def set_reverse_positions(board, piece)
    upper_left(board, piece); up(board, piece);  upper_right(board, piece)
    left(board, piece);                          right(board, piece)
    lower_left(board, piece); low(board, piece); lower_right(board, piece)
  end

  def search_recursion(board, piece, next_cell, exec_method_sym)
    if next_cell.piece?
      if next_cell.piece.enemy?(piece.flg)
        board.positions.buffs << {x: next_cell.x, y: next_cell.y}
        next_cell.send(exec_method_sym, *[board, piece])
      else
        board.positions.freeze_buffer; return
      end
    else
      board.positions.clear_buffer; return
    end
  end

  def upper_left(board, piece)
    if !board.min_limits.include?(@prev_x) and !board.min_limits.include?(@prev_y)
      search_recursion(board, piece, board.cells[@prev_x][@prev_y], __method__)
    end
  end

  def up(board, piece)
    if !board.min_limits.include?(@prev_y)
      search_recursion(board, piece, board.cells[@x][@prev_y], __method__)
    end
  end

  def upper_right(board, piece)
    if !board.max_limits.include?(@next_x) and !board.min_limits.include?(@prev_y)
      search_recursion(board, piece, board.cells[@next_x][@prev_y], __method__)
    end
  end

  def left(board, piece)
    if !board.min_limits.include?(@prev_x)
      search_recursion(board, piece, board.cells[@prev_x][@y], __method__)
    end
  end

  def right(board, piece)
    if !board.max_limits.include?(@next_x)
      search_recursion(board, piece, board.cells[@next_x][@y], __method__)
    end
  end

  def lower_left(board, piece)
    if !board.min_limits.include?(@prev_x) and !board.max_limits.include?(@next_y)
      search_recursion(board, piece, board.cells[@prev_x][@next_y], __method__)
    end
  end

  def low(board, piece)
    if !board.max_limits.include?(@next_y)
      search_recursion(board, piece, board.cells[@x][@next_y], __method__)
    end
  end

  def lower_right(board, piece)
    if !board.max_limits.include?(@next_x) and !board.max_limits.include?(@next_y)
      search_recursion(board, piece, board.cells[@next_x][@next_y], __method__)
    end
  end
end
