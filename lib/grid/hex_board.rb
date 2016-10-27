# @see http://rubyquiz.strd6.com/quizzes/190-hexagonal-grid-game-board
class HexBoard
  def initialize(rows = 20, cols = 20)
    @rows = rows
    @cols = cols
    @board = Array.new(@rows) do |_row|
      Array.new(@cols) do |_col|
        Hex.new
      end
    end
  end

  def distance(position1, position2)
    # Distance between two hexes on the board
  end

  def obstructed_distance(position1, position2, &block)
    # Distance between two hexes on the board having to navigate obstructions
    # Obstructions are detected by passing the hex in question into the block
    # block will return true if the yielded hex should be counted as obstructed
    # EX: dist = obstructed_distance(a, b) { |hex| hex.obstructed? }
  end

  # This will print the board out to the console to let you
  # know if you're on the right track
  def draw
    @rows.times do |row|
      line = ''
      (@cols - row).times { line << ' ' }

      @cols.times do |col|
        line << (distance([4, 4], [row, col]) || '*'.green).to_s
        line << ' '
      end
      puts line
    end
  end

  def [](row)
    @board[row]
  end
end
