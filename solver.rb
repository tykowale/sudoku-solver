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
  attr_reader :board

  def initialize
    f = File.open("./sudoku.txt")
    f_lines = f.read.split("\n")
    f_lines.each do |line|
      line.gsub!('+', '')
      line.gsub!('-', '')
      line.gsub!('|', '')
      line.gsub!('  ', '0')
      line.gsub!(/\s+/, '')
    end

    @board = []
    f_lines.each do |line|
      if line.size > 0
        @board.push(line.chars.map(&:to_i))
      end
    end
  end

  def row_possibilities
    #builds arrays that will match up with rows but be their opposite
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
        @col_possible[col] = @col_possible[col] - (Array(@board[row][col]) & @col_possible[col])
      end
    end
    p @col_possible
  end


  def box_possibilities
    @box_possible = Array.new(9) {Array(1..9).to_a}
    9.times do |row|
      @box_possible.each_index do |col|
        @box_possible[box_number(row, col)] = @box_possible[box_number(row, col)] - (Array(@board[row][col]) & @box_possible[box_number(row, col)])
      end
    end
    p @box_possible
  end

  def box_number(row, column)
    @box_num = ((row / 3) * 3 ) + (column / 3)
  end


end

game = SudokuSolver.new

puts 'board'
p game.board
puts
puts 'Column'
game.col_possibilities
puts
puts 'Row'
game.row_possibilities
puts
puts 'Box'
game.box_possibilities