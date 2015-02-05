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
      p possible_numbers.delete(board[((current_box / 3) * 3) + row_iterator][((current_box % 3) * 3) + col_iterator])
    end
  end
  possible_numbers
end

def guesser(value, board)

end

