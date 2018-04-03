# Build a method #bubble_sort that takes an array and returns a sorted array.
def bubble_sort(ary)
  swapped = true
  while swapped
    swapped = false
    (ary.length - 1).times do |i| # after ith pass, we don't need to check the end of the array
      if ary[i] > ary[i + 1]
        ary[i], ary[i + 1] = ary[i + 1], ary[i]

        swapped = true
      end
    end
  end
  ary
end

# Sorts an array by accepting a block. Remember to use yield inside your method definition
# to accomplish this. The block will have two arguments that represent the two elements of
# the array that are currently being compared. The block’s return will be similar to the
# spaceship operator you learned about before: If the result of the block execution is negative,
# the element on the left is “smaller” than the element on the right. 0 means both elements are equal.
# A positive result means the left element is greater. Use the block’s return value to sort your array.

def bubble_sort_by(ary)
  swapped = true
  while swapped
    swapped = false
    (ary.length - 1).times do |i| # after ith pass, we don't need to check the end of the array
      if yield(ary[i], ary[i + 1]) > 0
        ary[i], ary[i + 1] = ary[i + 1], ary[i]

        swapped = true
      end
    end
  end
  puts ary.inspect
end


puts bubble_sort([4,3,78,2,0,2]).inspect

bubble_sort_by(["hi","hello","hey", "gadzooks", "I"]) do |left,right|
  left.length - right.length
end
