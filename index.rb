# frozen_string_literal: true

module Enumerable
  def my_each
    arr = to_a
    arr.to_enum unless block_given?
    n = 0
    while arr.length > n
      yield(arr[n])
      n += 1
    end
	end
	
  def my_each_with_index
    arr = to_a
    return arr.to_enum unless block_given?
    n = 0
    while arr.length > n
      yield(arr[n], n)
      n += 1
    end
	end
	
  def my_select
    return self.to_enum unless block_given?
    res = []
    self.my_each do |v|
      res << v if yield(v) == true
    end
    res
  end
	
  def my_all?
    check = true
    if block_given?
      self.my_each{ |i| check = false unless yield(i)}
    else
      self.my_all?{ |obj| obj }
    end
    check
	end
	
  def my_any?
    check = false
    if block_given?
      my_each{ |i| check = true if yield(i) }
    else
      my_any?{ |obj| obj }
    end
    check
  end
	
  def my_none?
    check = true
    if block_given? 
      my_each{ |i| check = false if yield(i) }
    else
      my_none{ |obj| obj}
    end
    check
  end
	
  def my_count (*arg)
    count = 0
    unless block_given?
      if arg.empty?
        my_count { |i| i }
      else
        my_count { |i| arg[0] == i }
      end
    end
      my_each { |i| count += 1 if yield(i) }
    count
  end
	
  def my_map(&proc)
    return arr.to_enum unless block_given?
    result = []
    my_each { |i| result << proc.call(i) }
    result
	end
	
  def my_inject(init = nil)
     n = 0
     acc = init ? init + arr[0] : arr[0]
     if block_given?
       while arr.length-1 > n
         acc = yield(acc, arr[n+1])
         n += 1
       end
     end
     acc
  end
	
  def multiply_els(arr)
    my_inject(arr){ |i,j| i *j }
  end
end
