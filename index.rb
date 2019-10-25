module Enumerable
	def my_each
		raise "No block provided. Add a block" unless block_given?
		n=0
		while self.length > n
			yield(self[n])
			n += 1
		end
	end

	def my_each_with_index
		return self.to_enum unless block_given?
		n=0
		while self.length > n
			yield(self[n], n)
			n += 1
		end
	end

	def my_select
		return self.to_enum  unless block_given?
		res = []
		self.my_each do |v|
			res << v if yield(v) == true
		end
		res
	end

	def my_all?
		n=0
		check = true
		if block_given?
			while self.length > n
				check = false unless yield(self[n]) == true
				n += 1
			end

		else
			self.my_all?{ |obj| obj }
		end
		check
	end

	def my_any?
		n=0
		check = false
		if block_given?
			while self.length > n
				check = true if yield(self[n]) == true
				n += 1
			end
		else
			self.my_any?{ |obj| obj }
		end
		
		check
	end

	def my_none?
		n=0
		check = true
		if block_given? 
			while self.length > n
				check = false if yield(self[n]) == true
				n += 1
			end
		else
			self.my_none?
		end
		check
	end

	def my_count *arg
		n = 0
		count = 0
		unless block_given?
			if arg.empty?
				while self.length > n
					count +=1
					n += 1
				end
			else
				while arr.length > n
					count +=1 if check == arr[n]
					n += 1
				end
			end
		end

		while arr.length > n
			count += 1 if yield(arr[n]) == true
			n += 1
		end
		count

	end

	def my_map(arr)

		return arr unless block_given?
		result = []
		n = 0
		while arr.length > n
			result << yield(arr[n])
			n += 1
		end
		result

	end

	def my_inject (arr,init = nil)
		n = 0
		acc = init ? init + arr[0] : arr[0]

		if block_given?
			while arr.length-1 > n
				p "#{acc}, #{arr[n+1]}"
				acc = yield(acc, arr[n+1])
				n += 1
			end
		else
			# op = operation.to_s
			# p op
			# p 1.+ 2
		end
		acc

	end

	def multiply_els(arr)
		my_inject(arr){|i,j| i *j}
	end

end

class Test
	include Enumerable
end

test = Test.new
p test.my_select([1,34,5,65]){|i| i >= 5}
p test.my_all?([2,34,5,65,nil])#{|i| i > 1}
p test.my_any?([false,nil])#{|i| i > 1}
p test.my_none?([false,nil,true])#{|i| i < 1}
p test.my_count([1,34,5,65]){|i| i > 1}
p test.my_map([12,32,13,43]){ |i| i*2}
p test.my_inject([12,32,13,43],10){|n,m| n + m }
p test.multiply_els([2,4,5])

# p 1.+ 3
# test.my_each_with_index([1,34,5,65]){|i,j| p "#{i} : #{j}"}