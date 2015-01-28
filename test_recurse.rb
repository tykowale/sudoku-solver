def find(start, history, goal)
  if start == goal
    return history
  elsif start > goal
    p history
    return nil
  else
    find(start + 5, "(" + history + " + 5)", goal) ||
    find(start * 3, "(" + history + " * 3)", goal)
  end
end


p find(1, '1', 9)


