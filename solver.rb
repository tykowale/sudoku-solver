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

  def box_number(row, column)
    box_num = ((row / 3) * 3 ) + (column / 3)
  end

  def row_col_checker(row, col, value) #returns true if row/column contains value
    9.times do |cell|
      if @board[cell][col] == value
        return true
        break
      elsif @board[row][cell] == value
        return true
        break
      end
    end
    false
  end


  def box_checker(row_check, col_check, value) #returns true if box contains value
    box_array = Array.new(9){[]}
    9.times do |row|
      9.times do |col|
        box_array[box_number(row, col)] << @board[row][col] unless @board[row][col] == nil
      end
    end
    box_array[box_number(row_check % 9,col_check % 9)].include? (value)
  end

  def solver
    9.times do |row|
      9.times do |col|
        next if @board[row][col]
        p @board

        1.upto(9) do |value|

          next if row_col_checker(row, col, value)
          next if box_checker(row, col, value)

          @board[row][col] = value

          if solver
            return true
          else
            @board[row][col] = nil
          end
        end
        return false
      end
    end
    true
  end

end  #end SudokuSolver

############  All tests should return true.  #############
game = SudokuSolver.new
p game.board
p game.solver
p game.row_col_checker(3,6,5)