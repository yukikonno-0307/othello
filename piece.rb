
class Piece
  def initialize(flg)
    @pieces = {true => '○', false => '●'}
    @flg = flg
  end

  def reverse
    @flg = !@flg
  end

  def to_s
    @pieces[@flg]
  end
end
