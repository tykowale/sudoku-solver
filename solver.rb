# How I currently have this all planned out -
# Have array that keeps track of all needed numbers for each row, column, and box
# Iterate over each spot and check if there is only one possible solution
#   if there is replace it with that number
#   if not move onto the next one
#   if no item in the entire board is changed end the program
# For boxes I have it counted out like this
# -------------
# | 0 | 1 | 2 |
# -------------
# | 3 | 4 | 5 |
# -------------
# | 6 | 7 | 8 |
# -------------

# formula for figuring out what box you are in:
# Using ruby's floor division
# ((Row# / 3)*3) + (Col# / 3)
# so if you are at [3][5]
# (3/3)*3 + (5/3)
# (1*3) + 1 = 4



class SudokuSolver
  attr_reader :board, :col_possible, :row_possible, :box_possible

  def initialize
    f = File.open("./sudoku.txt")
    f_lines = f.read.split("\n")
    f_lines.each do |line|
      line.gsub!('+', '')
      line.gsub!('-', '')
      line.gsub!('|', '')
      line.gsub!('     ', '000')
      line.gsub!('  ', '0')
      line.gsub!(/\s+/, '')
    end

    @board = []
    f_lines.each do |line|
      if line.size > 0
        @board.push(line.chars.map(&:to_i))
      end
    end
    array_possibilities
  end

  def array_possibilities
    @row_possible = Array.new(9) {Array(1..9).to_a}
    @col_possible = Array.new(9) {Array(1..9).to_a}
    @box_possible = Array.new(9) {Array(1..9).to_a}
    row_checker
    col_checker
    box_checker
  end

  def row_checker
    @row_possible.each_index do |row|
      @row_possible[row] = @row_possible[row] - (@board[row] & @row_possible[row])
    end
  end


  def col_checker
    9.times do |row|
      @col_possible.each_index do |col|
        @col_possible[col] = @col_possible[col] - (Array(@board[row][col]) & @col_possible[col])
      end
    end
  end


  def box_checker
    9.times do |row|
      @box_possible.each_index do |col|
        @box_possible[box_number(row, col)] = @box_possible[box_number(row, col)] - (Array(@board[row][col]) & @box_possible[box_number(row, col)])
      end
    end
  end

  def box_number(row, column)
    @box_num = ((row / 3) * 3 ) + (column / 3)
  end

  def reduce
    #row.each_index
    # col.each_index
    #   if (row_possible & col_possible & box_possible).size == 1
    #     @board[r][c] is that number
    #   else if (row_possible & col_possible & box_possible).size == 1
    #     games impossible and break
    #   else
    #     next
    #have counter going to make sure at least one thing is changed per go around,
    #if not end it and say it can't be solved
  end

  def spot_possible(row, column)  #checks possible solutions for specific spot on board
    @possibilities = (@row_possible[row] & @col_possible[column] & @box_possible[box_number(row,column)])

    if @board[row][column] != 0  #if spot isn't empty...
      return @board[row][column] = @board[row][column]  #returns itself
    elsif @possibilities.length == 1
      @board[row][column] = @possibilities[0]
      row_checker
      col_checker
      box_checker
      return @board[row][column]
    else
      return @possibilities #prints numbers that are possible for row, column, box
    end
  end

  def solver
    9.times do |row|
      9.times do |col|
        spot_possible(row, col)
      end
    end
  end

end

def foo
  puts "this is a test for git"
end

def bar
  puts "test 2"
end

def baz
  puts "test 3"
end

def foobarbaz
  puts "test4"
end

#testing chase_branch

game = SudokuSolver.new
p game.row_possible
1000.times {game.solver}
p game.row_possible
p game.col_possible[8]
p game.box_possible[5]
p game.spot_possible(0,0) == 5
p game.spot_possible(0,2) == [1,2,3]  #=> I solved this and the solution here is 3.  we need to check this array against other rows now to get rid of the 1 and 2
p game.board

# Here is where I am calling it quits for the night. If you decide to pick up
# everything is working as is intended right now but the changes I need to make for
# reusability and clarity purposes for what is written are as follows -
# 1. Change the function structure
#   Have an array_possibilites builder function
#   Have a row_check, column_check, box_check function
# 2. Change the naming to make more sense
# 3. Clean up the initialize statement and seperate it into a builder function?


# puts 'board'
# p game.board
# puts

# puts 'Column'
# p game.col_possible
# puts

# puts 'Row'
# p game.row_possible
# puts

# puts 'Box'
# p game.box_possible
# puts



# this is a git test!






