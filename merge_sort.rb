# 1 split entire data set in half until each separate list contains a single element
# 2 now we merge lists together on the first level of the stack which leaves us with
# half as many lists as we once had

def merge_sort(ary)
  if ary.size == 1
    return ary
  end

  mid = ary.count / 2

  part_a = merge_sort(ary[0...(ary.size/2)])
  part_b = merge_sort(ary[(ary.size/2)..-1])

  # 2. Conquer
  array = []
  offset_a = 0
  offset_b = 0
  while offset_a < part_a.count && offset_b < part_b.count
      a = part_a[offset_a]
      b = part_b[offset_b]

      # Take the smallest of the two, and push it on our array
      if a <= b
          array << a
          offset_a += 1
      else
          array << b
          offset_b += 1
      end
  end

  # There is at least one element left in either part_a or part_b (not both)
  while offset_a < part_a.count
      array << part_a[offset_a]
      offset_a += 1
  end

  while offset_b < part_b.count
      array << part_b[offset_b]
      offset_b += 1
  end

  return array
end

#ary [5, 3, 9, 8]

puts merge_sort([5, 3, 72, 94, 48, 30]).inspect
