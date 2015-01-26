class SudokuSolver

  def initialize
    f = File.open("./sudoku.txt")
    f_lines = f.read.split("\n")
    f_lines.each do |line|
      line.gsub!('+', '')
      line.gsub!('-', '')
      line.gsub!('|', '')
      line.gsub!('  ', '0')
      line.gsub!(/\s+/, "")
    end

    @board = []
    f_lines.each do |line|
      if line.size > 0
        @board.push(line.chars.map(&:to_i))
      end
    end
  end


  def row_possibilities
    @row_possible = Array.new(9) {Array(1..9).to_a}
    @row_possible.each_index do |row|
      @row_possible[row] = @row_possible[row] - (@board[row] & @row_possible[row])
    end
    p @row_possible
  end

  def col_possibilities
    @col_possible = Array.new(9) {Array(1..9).to_a}
    9.times do |row|
      @col_possible.each_index do |col|
        @col_possible[col] = @col_possible[col] - (@board[row][col] & @col_possible[row][col])
      end
    end
    p @col_possible
  end

end

SudokuSolver.new.col_possibilities
SudokuSolver.new.row_possibilities