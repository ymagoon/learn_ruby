=begin
Implement a method #stock_picker that takes in an array of stock prices, one for each hypothetical day.
It should return a pair of days representing the best day to buy and the best day to sell. Days start at 0.

  > stock_picker([17,3,6,9,15,8,6,1,10])
  => [1,4]  # for a profit of $15 - $3 == $12
=end

def stock_picker(*args)
  # set default values
  days = *args
  diff = 0
  min = days[0]
  buy = 0
  sell = 0

  days.each_with_index do |price, index|
    if price - min > diff
      diff = price - min
      sell = index
    end

    if price < min
      min = price
      buy = index
    end
  end
  return "#{[buy,sell]} has the max difference of #{diff}"
end

puts stock_picker(3,2,19,3,1004)
