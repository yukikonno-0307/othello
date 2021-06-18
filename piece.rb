
class Piece
  def initialize
    @pieces = {true => '○', false => '●'}
    @flg = nil
    @init_char = ' '
  end

  def reverse
    @flg = !@flg
  end

  def put(player)
    @flg = player.color
  end

  def to_s
    @flg.nil? ? @init_char : @pieces[@flg]
  end
end
