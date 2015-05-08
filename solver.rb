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

    @board = [[1, nil, 5, 8, nil, 2, nil, nil, nil],
[nil, 9, nil, nil, 7, 6, 4, nil, 5],
[2, nil, nil, 4, nil, nil, 8, 1, 9],
[nil, 1, 9, nil, nil, 7, 3, nil, 6],
[7, 6, 2, nil, 8, 3, nil, 9, nil],
[nil, nil, nil, nil, 6, 1, nil, 5, nil],
[nil, nil, 7, 6, nil, nil, nil, 3, nil],
[4, 3, nil, nil, 2, nil, 5, nil, 1],
[6, nil, nil, 3, nil, 8, 9, nil, nil]]

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
        next if @board[row][col] #skips over cells that contain values
        1.upto(9) do |value|

          next if row_col_checker(row, col, value) #skips current number if value is in row/column
          next if box_checker(row, col, value) #skips current number if value is in box
          @board[row][col] = value
          if solver #see end of solver where it will return true
            return true
          else
            @board[row][col] = nil #heart of the code, forces back tracking
          end
        end
        return false

      end
    end
    p @board
    return true
  end

end  #end SudokuSolver

############  All tests below this line  #############
game = SudokuSolver.new
p game.board
p game.solver
