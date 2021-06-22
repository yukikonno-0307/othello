
class ReversePositions
  def initialize
    @buffs = []
    @freezes = nil
  end

  def freeze_buffer
    @freezes = @buffs
  end

  def clear_buffer
    @buffs = [] if @buffs.length > 0
  end

  def reset
    clear_buffer
    @freezes = nil unless @freezes.nil!
  end
end
