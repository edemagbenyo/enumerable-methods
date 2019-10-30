# frozen_string_literal: true

# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each
    arr = to_a
    return arr.to_enum unless block_given?

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
    return to_enum unless block_given?

    res = []
    my_each do |v|
      res << v if yield(v) == true
    end
    res
  end

  def my_all?(*args)
    check = true
    if block_given?
      if args.empty?
        my_each { |i| check = false unless yield(i) }
      elsif args[0].is_a?(Class)
        my_each { |i| check = false unless yield(i).class == args[0] }
      elsif args[0].is_a?(Regexp)
        my_each { |i| check = false unless (args[0]).match(yield(i)) }
      else
        my_each { |i| check = false unless yield(i) == args[0] }
      end
      return check
    elsif args.empty?
      my_all? { |obj| obj }
    else
      my_all?(args[0]) { |obj| obj }
    end
  end

  def my_any?(*args)
    check = false
    if block_given?
      if args.empty?
        my_each { |i| check = true if yield(i) }
      elsif args[0].is_a?(Class)
        my_each { |i| check = true if yield(i).class == args[0] }
      elsif args[0].is_a?(Regexp)
        my_each { |i| check = true if yield(i).match(args[0]) }
      else
        my_each { |i| check = true if yield(i) == args[0] }
      end
      return check
    elsif args.empty?
      my_any? { |obj| obj }
    else
      my_any?(args[0]) { |obj| obj }
    end
  end

  def my_none?(*args)
    check = true
    if block_given?
      if args.empty?
        my_each { |i| check = false if yield(i) }
      elsif args[0].is_a(Class)
        my_each { |i| check = false if yield(i).class == args[0] }
      elsif args[0].is_a(Regexp)
        my_each { |i| check = false if yield(i).match(args[0]) }
      else
        my_each { |i| check = false if yield(i) == args[0] }
      end
      return check
    elsif args.empty?
      my_none? { |obj| obj }
    else
      my_none?(args[0]) { |obj| obj }
    end
  end

  def my_count(*arg)
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
    arr = to_a
    return arr.to_enum unless block_given?

    result = []
    my_each { |i| result << proc.call(i) }
    result
  end

  def my_inject(*args)
    arr = to_a
    acc = 0
    if block_given?
      acc = args[0] || 0
      my_each_with_index { |_, i| acc = yield(acc, arr[i]) }
    elsif args[0].is_a?(Integer) && args[1].is_a?(Symbol)
      acc = args[0]
      my_each_with_index { |_, i| acc = args[1].to_proc.call(acc, arr[i]) }
    elsif args[0].is_a?(Symbol)
      my_each_with_index { |_, i| acc = args[0].to_proc.call(acc, arr[i]) }
    end
    acc
  end
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ModuleLength

def multiply_els(arr)
  arr.my_inject { |i, j| i * j }
end
