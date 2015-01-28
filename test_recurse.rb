def find(start = 1, history = '1', goal)
  if start == goal
    return history
  elsif start > goal
    return nil
  else
    find(start + 5, "(" + history + " + 5)", goal) ||
    find(start * 3, "(" + history + " * 3)", goal)
  end
end


p find(99)
