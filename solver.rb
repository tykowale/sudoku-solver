# For boxes I have it counted out like this:
# -------------
# | 0 | 1 | 2 |
# -------------
# | 3 | 4 | 5 |
# -------------
# | 6 | 7 | 8 |
# -------------

class SudokuSolver
  attr_reader :board, :col_possible, :row_possible, :box_possible

  def initialize
    @row_possible = Array.new(9) {Array(1..9).to_a}  #[1,2,3,4,5,6,7,8,9] ...these will change
    @col_possible = Array.new(9) {Array(1..9).to_a}  #[1,2,3,4,5,6,7,8,9]
    @box_possible = Array.new(9) {Array(1..9).to_a}  #[1,2,3,4,5,6,7,8,9]

    f = File.open("./sudoku.txt")
    f_lines = f.read.split("\n")
    f_lines.each do |line|  #gets rid of borders and puts 0s in empty cells
      line.gsub!('+', '')
      line.gsub!('-', '')
      line.gsub!('|', '')
      line.gsub!('     ', '000')
      line.gsub!('  ', '0')
      line.gsub!(/\s+/, '')  #cuts down excessive white space to single spaces
    end

    @board = []
    f_lines.each do |line|  #pushes cleaned up file lines into arrays
      if line.size > 0
        @board.push(line.chars.map(&:to_i))
      end
    end
  end #initialize

  def box_number(row, column)
    @box_num = ((row / 3) * 3 ) + (column / 3)
  end

  def row_checker  #checks all possible solutions in a row
    @row_possible.each_index do |row|
      @row_possible[row] = @row_possible[row] - (@board[row] & @row_possible[row])
    end
  end

  def col_checker  #checks all possible solutions in a column
    @col_possible.each_index do |col|
      @col_possible[col] = @col_possible[col] - (Array(@board.transpose[col]) & @col_possible[col])
    end
  end

  def box_checker
    9.times do |row|
      @box_possible.each_index do |col|
        @box_possible[box_number(row, col)] = @box_possible[box_number(row, col)] - (Array(@board[row][col]) & @box_possible[box_number(row, col)])
      end
    end
  end

  def marker(row, column)  #checks all possible solutions for specific spot on board
    @possibilities = (@row_possible[row] & @col_possible[column] & @box_possible[box_number(row,column)])

    if @board[row][column] != 0  #if spot isn't 0...
      return @board[row][column] = @board[row][column]  #returns itself
    elsif @possibilities.length == 1
      @board[row][column] = @possibilities[0]
      row_checker
      col_checker
      box_checker
      return @board[row][column]
    else
      @board[row][column] = @possibilities
      return @possibilities #prints numbers that are possible for row, column, box
    end
  end

  def solver
    9.times do |row|
      9.times do |col|
        marker(row, col)
      end
    end
  end

end


############  All tests should return true.  #############
game = SudokuSolver.new

p game.row_checker[1] == [1,2,4,6,7,8,9]
p game.col_checker[0] == [2,3,6,8,9]
p game.box_checker[1] == [1,2,4,6,7,9]  #this is confusing me


########### Display ############
1000.times{game.solver}
p game.board
















