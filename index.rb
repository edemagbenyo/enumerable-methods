module Enumerable
	def my_each(arr)
		n=0
		while arr.length > n
			raise "No block provided. Add a block" unless block_given?
			yield(arr[n])
			n += 1
		end
	end

	def my_each_with_index(arr)
		n=0
		while arr.length > n
			raise "No block provided. Add a block" unless block_given?
			yield(arr[n], n)
			n += 1
		end
	end

	def my_select(arr)
		res = []
		my_each(arr)do |v|
			raise "No block provided. Add a block" unless block_given?
			res << v if yield(v) == true
		end
		res
	end

	def my_all?(arr)
		n=0
		check = true
		while arr.length > n
			raise "No block provided. Add a block" unless block_given?
			check = false unless yield(arr[n]) == true
			n += 1
		end
		check
	end

	def my_any?(arr)
		n=0
		check = false
		while arr.length > n
			raise "No block provided. Add a block" unless block_given?
			check = true if yield(arr[n]) == true
			n += 1
		end
		check
	end

	def my_none?(arr)
		n=0
		check = true
		while arr.length > n
			raise "No block provided. Add a block" unless block_given?
			check = false if yield(arr[n]) == true
			n += 1
		end
		check
	end

end

class Test
	include Enumerable
end

test = Test.new
p test.my_select([1,34,5,65]){|i| i >= 5}
p test.my_all?([1,34,5,65]){|i| i > 1}
p test.my_any?([1,0,34,5,65]){|i| i > 1}
p test.my_none?([0,1,34,5,65]){|i| i < 1}
# test.my_each_with_index([1,34,5,65]){|i,j| p "#{i} : #{j}"}