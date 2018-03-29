#write your code here
def add(n1, n2)
  return n1 + n2
end

def subtract(n1, n2)
  return n1 - n2
end

def sum(numbers)
  sum = 0

  if !numbers.empty?
    sum = numbers.reduce(:+)
  end
  return sum
end

def multiply(n1, *args)
  return n1 * args.reduce(:*)
end

def power(n1, n2)
  return n1 ** n2
end

def factorial(n)
  if n == 0 || n == 1
    return 1
  end

  return factorial(n - 1) * n
end
