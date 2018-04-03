module Enumerable

  def my_each
    i = 0
    if block_given?
      while i < self.size
        yield self[i]
        i += 1
      end
      self
    else
      self.to_enum
    end
  end

  def my_each_with_index
    i = 0
    if block_given?
      while i < self.size
        yield self[i], i
        i += 1
      end
      self
    else
      self.to_enum
    end
  end

  def my_select
    col = []
    if block_given?
      self.my_each { |value| col << value if yield value }
    else
      self.enum
    end
    col
  end

  def my_all?
    if block_given?
      self.my_each { |value| return false unless yield value }
      return true
    else
      self.include?(nil) || self.include?(false) ? false : true
    end
  end

  def my_any?
    if block_given?
      self.my_each { |value| return true if yield value }
      return false
    else
      self.my_each { |value| return true if value }
      return false
    end
  end

  def my_none?
    if block_given?
      self.my_each { |value| return false if yield value }
      return true
    else
      self.my_each { |value| return false if value }
      return true
    end
  end

  def my_count(param = nil)
    cnt = 0
    if block_given?
      self.my_each { |value| cnt += 1 if yield value }
    else
      if param.nil?
        self.each { cnt += 1 }
        cnt
      else
        cnt = param
      end
    end
    cnt
  end

  def my_map(proc = nil)
    new_arr = []
    if block_given?
      self.my_each do |value|
        new_arr << yield(value)
      end
    else
      if !proc.nil?
        self.my_each do |value|
          new_arr << proc.call(value)
        end
      else
        return self.to_enum
      end
    end
    new_arr
  end

  def my_inject(memo = nil)
    if block_given?
      memo ? memo = yield(memo, self.first) : memo = self.first
      self.drop(1).my_each do |elem|
        memo = yield(memo, elem)
      end
      memo
    else
      to_enum(:my_inject)
    end
  end
end

def multiply_els(ary)
  return ary.my_inject { |sum, i| sum * i }
end

puts multiply_els([2,4,5])

#puts [1,2,3,4].my_inject(0) { |memo, i| memo+i}
#puts [1,2,3,4].my_inject { |memo, i| memo+i} # works great
puts (1..5).my_inject { |memo, i| memo+i } # NoMethodError
