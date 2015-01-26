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
# ((Row# % 3)*3) + (Col# % 3)
# so if you are at [3][5]
# (3%3)*3 + (5%3)
# (1*3) + 1 = 4



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

  def row_checker
    #Checks if a number is in a row and removes it from the possibilities array
    @row_possible.each_index do |row|
      @row_possible[row] = @row_possible[row] - (@board[row] & @row_possible[row])
    end
  end

  def row_possibilities
    #builds arrays that has all will match up with rows
    @row_possible = Array.new(9) {Array(1..9).to_a}
    row_checker
    p @row_possible
  end


# This is currently not working but I want it to function similar to the row check
# but it is a little bit harder since you have to account got not looping over
# an array, but instead a bunch of individual digits. Is there a way to transpose
# so it switches them around to make it easier?
  # def col_possibilities
  #   @col_possible = Array.new(9) {Array(1..9).to_a}
  #   9.times do |row|
  #     @col_possible.each_index do |col|
  #       @col_possible[col] = @col_possible[col] - (@board[row][col] & @col_possible[row][col])
  #     end
  #   end
  #   p @col_possible
  # end

end

# SudokuSolver.new.col_possibilities
SudokuSolver.new.row_possibilities