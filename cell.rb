
class Cell
  attr_reader :x, :y
  attr_accessor :piece
  def initialize(x, y)
    @x = x
    @y = y
    @piece = nil

    @prev_x = x - 1; @next_x = x + 1
    @prev_y = y - 1; @next_y = y + 1
  end

  def piece?
    !@piece.nil?
  end

  def put(board, piece)
    set_reverse_positions(board, piece)
  end

  def to_s
    @piece.nil? ? ' ' : @piece.to_s
  end

  def set_reverse_positions(board, piece)
    upper_left(board, piece)
    up(board, piece)
    upper_right(board, piece)
    #left(board, positions)
    #right(board, positions)
    #lower_left(board, positions)
    #low(board, positions)
    #lower_right(board, positions)
  end

  def upper_left(board, piece)
    if !board.min_limits.include?(@prev_x) and !board.min_limits.include?(@prev_y)
      next_cell = board.cells[@prev_x][@prev_y]
      if next_cell.piece?
        if next_cell.piece.enemy?(piece.flg)
          board.positions << {x: next_cell.x, y: next_cell.y}
          next_cell.upper_left(board, piece)
        elsif !next_cell.piece.enemy?(piece.flg)
          return
        else
          board.positions = []
        end
      end
    end
  end

  def up(board, piece)
    if !board.min_limits.include?(@prev_y)
      next_cell = board.cells[@x][@prev_y]
      if next_cell.piece?
        if next_cell.piece.enemy?(piece.flg)
          board.positions << {x: next_cell.x, y: next_cell.y}
          next_cell.up(board, piece)
        elsif !next_cell.piece.enemy?(piece.flg)
          return
        else
          board.positions = []
        end
      end
    end
  end

  
end
=begin
  def up?(board, positions)
    if !board.min_limits.include?(@prev_y)
      board.cells[@x][@prev_y].piece.enemy?(@piece.flg)
    end
    false
  end

  def upper_right(board, positions)
    if !board.max_limits.include?(@next_x) and !board.min_limits.include?(@prev_y)
      board.cells[@next_x][@prev_y].piece.enemy?(@piece.flg)
    end
    false
  end

  def left(board, positions)
    if !board.min_limits.include?(@prev_x)
      board.cells[@prev_x][@y].piece.enemy?(@piece.flg)
    end
    false
  end

  def right(board, positions)
    if !board.max_limits.include?(@next_x)
      board.cells[@next_x][@y].piece.enemy?(@piece.flg)
    end
    false
  end

  def lower_left(board, positions)
    if !board.min_limits.include?(@prev_x) and !board.max_limits.include?(@next_y)
      board.cells[@prev_x][@next_y].piece.enemy?(@piece.flg)
    end
    false
  end

  def low(board, positions)
    if !board.max_limits.include?(@next_y)
      board.cells[@x][@next_y].piece.enemy?(@piece.flg)
    end
    false
  end

  def lower_right(board, positions)
    if !board.max_limits.include?(@next_x) and !board.max_limits.include?(@next_y)
      board.cells[@next_x][@next_y].piece.enemy?(@piece.flg)
    end
    false
  end
end
=end
