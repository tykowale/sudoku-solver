# For boxes I have it counted out like this:
# -------------
# | 0 | 1 | 2 |
# -------------
# | 3 | 4 | 5 |
# -------------
# | 6 | 7 | 8 |
# -------------

class SudokuSolver
  attr_reader :board

  def initialize

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
        @board.push(line.chars.map {|x| x = x.to_i if x.to_i > 0})
      end
    end

  end

  def row_col_checker(row, col, value) #returns true if row/column contains value
    9.times do |cell|
      if @board[cell][col] == value
        return false
        break
      elsif @board[row][cell] == value
        return false
        break
      else
        return true
      end
    end
  end


  def box_checker(row, col, value) #returns true if box contains value
    #check if box contains value, if it does return true


  end

  def solver
    #iterate row
    #iterate col
    #next if cell is a value (not nil)
      #start at 1 upto 9 w/ variable value
        #check if row/col contain value
        #check if box contains value
        #if neither [row][col] = value
        #return true
        #at this point it loops back up to the first 'next if' statement
        #
    # if solver = true return board
    #else [row][col] = nil

end  #end SudokuSolver

############  All tests should return true.  #############
game = SudokuSolver.new
p game.board

