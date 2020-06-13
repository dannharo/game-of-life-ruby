load 'cell.rb'
require 'pry'

class Game
  attr_reader :cells
  SHOW_SQUARE =
      {
          'true': '▓▓',
          'false': '░░'
      }.freeze

  def initialize(witdth, height)
    @cells = []
    @width = witdth
    @height = height
    witdth.times do |x|
      @cells.push([])
      height.times do |y|
        @cells[x].push(Cell.new(self, x, y))
      end
    end
  end

  def current_generation
    show_board
  end

  def next_generation
    puts '='*100
    @next_gen = @cells.dup
    @cells.each do |cell_inside|
      cell_inside.each do |cell|
        if cell.live && neighbors(cell) > 3
          @next_gen.dig(cell.position_x, cell.position_y).live = false
        elsif cell.live && neighbors(cell) > 1
          @next_gen.dig(cell.position_x, cell.position_y).live = true
        elsif cell.live && neighbors(cell) < 2
          @next_gen.dig(cell.position_x, cell.position_y).live = false
        elsif !cell.live && neighbors(cell) == 3
          @next_gen.dig(cell.position_x, cell.position_y).live = true
        end

      end
    end
    @cells = @next_gen

    show_board
  end

  def neighbors(cell)
    posx = cell.position_x
    posy = cell.position_y
    neighbors = []
    # left
    neighbors.push(@cells[posx - 1][posy + 1].live) if inside_board?(posx - 1, posy + 1)
    neighbors.push(@cells[posx - 1][posy].live) if inside_board?(posx - 1, posy)
    neighbors.push(@cells[posx - 1][posy - 1].live) if inside_board?(posx - 1, posy - 1)

    # up and down
    neighbors.push(@cells[posx][posy + 1].live) if inside_board?(posx, posy + 1)
    neighbors.push(@cells[posx][posy - 1].live) if inside_board?(posx, posy - 1)

    #right
    neighbors.push(@cells[posx + 1][posy + 1].live) if inside_board?(posx + 1, posy + 1)
    neighbors.push(@cells[posx + 1][posy].live) if inside_board?(posx + 1, posy)
    neighbors.push(@cells[posx + 1][posy - 1].live) if inside_board?(posx + 1, posy - 1)

    neighbors.count(true)
  end

  private

  def inside_board?(x, y)
    true if x < @width && x >= 0 && y < @height && y >= 0
  end

  def show_board
    puts @cells.map {|s| s.map {|a| SHOW_SQUARE[a.live.to_s.to_sym]}.join(' ') }
  end
end

game = Game.new(10,10)
game.current_generation
game.next_generation
