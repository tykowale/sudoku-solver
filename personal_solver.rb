sudoku = [[1, nil, nil, nil, nil, 7, nil, 9, nil], [nil, 3, nil, nil, 2, nil, nil, nil, 8], [nil, nil, 9, 6, nil, nil, 5, nil, nil], [nil, nil, 5, 3, nil, nil, 9, nil, nil], [nil, 1, nil, nil, 8, nil, nil, nil, 2], [6, nil, nil, nil, nil, 4, nil, nil, nil], [3, nil, nil, nil, nil, nil, nil, 1, nil], [nil, 4, nil, nil, nil, nil, nil, nil, 7], [nil, nil, 7, nil, nil, nil, 3, nil, nil]]

def box_number(row, col)
  ((row / 3) * 3) + (col / 3)
end

def row_col_possible_numbers(row, col, board)
  possible_numbers = (1..9).to_a
  9.times do |cell|
    possible_numbers.delete(board[row][cell])
    possible_numbers.delete(board[cell][col])
  end
  possible_numbers
end

def box_possible_numbers(row, col, board)
  possible_numbers = (1..9).to_a
  current_box = box_number(row, col)
  3.times do |row_iterator|
    3.times do |col_iterator|
      possible_numbers.delete(board[((current_box / 3) * 3) + row_iterator][((current_box % 3) * 3) + col_iterator])
    end
  end
  possible_numbers
end

def next_empty_cell(board)
  location = board.flatten(1).index(nil)
  row = location / 9
  col = location % 9
  [row, col]
end

def guesser(value, board)
  guesser_cell = next_empty_cell(board)
  next_row = guesser_cell[0]
  next_col = guesser_cell[1]
  cell_possibilities = (row_col_possible_numbers(next_row, next_col, board) & box_possible_numbers(next_row, next_col, board))
  if guesser_cell == nil
    return board
  elsif cell_possibilities == []
    return nil
  else
    board[next_row][next_col] = cell_possibilities[value]
    guesser(0, board) ||
    guesser(1, board) ||
    guesser(2, board) ||
    guesser(3, board) ||
    guesser(4, board) ||
    guesser(5, board)
  end

end

p guesser(2, sudoku)