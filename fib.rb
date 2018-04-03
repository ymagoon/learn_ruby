def fibonacci(n, memo = {})
  return n if n <= 2
  return memo[n] ||= fibonacci(n - 1) + fibonacci(n - 2)
end

puts fibonacci(5).inspect
