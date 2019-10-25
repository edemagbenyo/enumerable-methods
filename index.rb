module Enumerable
	def my_each
		self.to_enum unless block_given?
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
			self.my_each{ |i| check = false unless yield(i)}
		else
			self.my_all?{ |obj| obj }
		end
		check
	end

	def my_any?
		n=0
		check = false
		if block_given?
			self.my_each{ |i| check=true if yield(i) }
		else
			self.my_any?{ |obj| obj }
		end
		
		check
	end

	def my_none?
		n=0
		check = true
		if block_given? 
			self.my_each{ |i| check=false if yield(i) }
		else
			self.my_none{ |obj| obj}
		end
		check
	end

	def my_count *arg
		n = 0
		count = 0
		unless block_given?
			if arg.empty?
				self.my_count { |i| i }
			else
				self.my_count { |i| arg[0] == i }
			end
		end
		self.my_each { |i| count += 1 if yield(i) }
		count

	end

	def my_map(&proc)

		return arr.to_enum unless block_given?
		result = []
		n = 0
		self.my_each { |i| result << proc.call(i) }
		result

	end

	def my_inject init = nil
		n = 0
		acc = init ? init + arr[0] : arr[0]

		if block_given?
			while arr.length-1 > n
				acc = yield(acc, arr[n+1])
				n += 1
			end
		else
		end
		acc

	end

	def multiply_els(arr)
		my_inject(arr){|i,j| i *j}
	end

end
