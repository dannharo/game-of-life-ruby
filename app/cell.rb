class Cell
  attr_reader :game, :position_x, :position_y
  attr_accessor :live

  def initialize(game, x, y)
    @game = game
    @position_x = x
    @position_y = y
    @live = [true, false].sample
  end
end