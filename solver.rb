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
  attr_accessor :solved

  def initialize(solved=false)
    @row_possible = Array.new(9) {Array(1..9).to_a}  #[1,2,3,4,5,6,7,8,9] ...these will change
    @col_possible = Array.new(9) {Array(1..9).to_a}  #[1,2,3,4,5,6,7,8,9]
    @box_possible = Array.new(9) {Array(1..9).to_a}  #[1,2,3,4,5,6,7,8,9]
    @solved = solved

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

  def row_checker(row)  #checks all possible solutions in a row
    @row_possible[row] -= (@board[row] & @row_possible[row])
  end

  def col_checker(col)  #checks all possible solutions in a column
    @col_possible[col] -= (Array(@board.transpose[col]) & @col_possible[col])
  end

  def box_checker
    9.times do |row|  #iterates every row
      @box_possible.each_index do |col|  # column
        @box_possible[box_number(row, col)] -= (Array(@board[row][col]) & @box_possible[box_number(row, col)]) if @board[row][col].is_a?(Integer)
      end
    end
    @box_possible
  end

  def cell_checker(row, col)  #checks all possible solutions for specific spot on board
    @board[row][col] = 0 if @board[row][col].is_a?(Array)
    @possibilities = (row_checker(row) & col_checker(col) & box_checker[box_number(row,col)])

    if @board[row][col] != 0  #if spot isn't 0...
      return @board[row][col] = @board[row][col]  #returns itself
    elsif @possibilities.length == 1
      @board[row][col] = @possibilities[0]
      row_checker(row)
      col_checker(col)
      box_checker
      return @board[row][col]
    else
      @board[row][col] = @possibilities
    end
  end

  def marker
    9.times do |row|
      9.times do |col|
        cell_checker(row, col)
      end
    end
  end

  def show_row
    @board.each {|row| row}
  end

  def show_col
    @board.transpose.each {|col| col}
  end

  def show_box
    @box_array = Array.new(9){[]}
    9.times do |row|
      9.times do |col|
        @box_array[box_number(row, col)] << @board[row][col]
      end
    end
  end

  def win?
    show_box
    winner = []
    @box_array.each_index do |box|
      winner << @box_array[box].inject(:+)
    end
    show_row.each_index do |row|
      winner <<  show_row[row].inject(:+)
    end
    show_col.each_index do |col|
      winner << show_col[col].inject(:+)
    end
    return winner.all? {|num| num == 45}
  end

  def valid?
    @board.any? {|x| x = []}
  end

  # def guesser(index)
  #   @board.each_index do |row|
  #     @board[row].find_index do |x|
  #       @board[row][x] = @board[row][x][index] if x.is_a?(Array)
  #       break
  #     end
  #   end
  #
  def guesser(index)  #insterts a guess when a cell has multiple possibilities
    9.times do |row|
      9.times do |col|
        if @board[row][col].is_a?(Array)
          @board[row][col] =  @board[row][col][index]  #chooses one possibility at random
          marker
          break
        end
      end #col
    end #row
  end

end  #end SudokuSolver

############  All tests should return true.  #############
game = SudokuSolver.new
# p game.marker
p game.board
p game.marker
p game.board
p game.row_checker(0)
p game.col_checker(0)
p game.box_checker[0]
# p game.cell_checker(0,1)
# p game.box_checker[0]
# p game.row_checker(0)





