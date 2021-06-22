
class ReversePositions
  attr_reader :buffs
  def initialize
    @buffs = []
    @freezes = nil
  end

  def presence?
    !@freezes.nil?
  end

  def freeze_buffer
    @freezes = @buffs
  end

  def clear_buffer
    @buffs = [] if @buffs.length > 0
  end

  def reset
    clear_buffer
    @freezes = nil unless @freezes.nil?
  end

  def iter_positions
    @freezes.each do |p|
      yield p
    end
  end
end
