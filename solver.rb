class SudokuSolver

  def reduce

  end

end

f = File.open("./sudoku.txt")

f_lines = f.read.split("\n")

f_lines.each do |line|
  line.gsub!('+', '')
  line.gsub!('-', '')
  line.gsub!('|', '')
  line.gsub!('  ', '0')
  line.gsub!(/\s+/, "")
end

board = []
f_lines.each do |line|
  if line.size > 0
    board.push(line.chars.map(&:to_i))
  end
end

print board
