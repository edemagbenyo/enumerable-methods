# frozen_string_literal: true

require_relative('../index')
describe Enumerable do
  describe '#my_select' do
    it 'returns an enumerator back when no block is given' do
      expect([1, 2, 3, 4].my_select).to be_kind_of(Enumerator)
    end
    it 'returns all elements for which the block returns true' do
      expect([1, 2, 3, 4].my_select{|i| i > 2}).to be == [3, 4]
    end
  end
  describe '#my_all' do
    it 'returns true if no element return false or nil when passed to the block' do
      expect([1, 2, 3, 4].my_all?{ |i| i >= 1 }).to be_truthy
    end
    it 'returns true if all elements are of the same class as the class passed as argument' do
      expect([1, 2, 3, 4].my_all?(Integer)).to be_truthy
    end
    it 'returns true if all elements match the Regexp that passed as argument' do
      expect(['hi','hi hello','hi there'].my_all?(/(hi)/){ |i| i }).to be_truthy
    end
    it 'returns true if all elements match the element passed as argument' do
      expect([1, 1, 1, 1].my_all?(1)).to be_truthy
    end
    it 'returns true if no element return false or nil when no block is given' do
      expect([1, 2, 3, 4].my_all?).to be_truthy
    end
  end
  describe '#my_any' do
    it 'returns true if at least one of the element is not false or nil when passed to a block' do
      expect(['Edem', 'John' ,21 , [1,5]].my_any?{ |i| i.class == String }).to be_truthy
    end
    it 'returns true if at least one element is of the same class as the class passed as argument' do
      expect(['Sam', 'John' ,12 , 56].my_any?(String)).to be_truthy
    end
    it 'returns true if at least one element match the Regexp that passed as argument' do
      expect(['hi hello', 'hola', 'Como estas?'].my_any?(/(estas)/)).to be_truthy
    end
    it 'returns true if at least one element match the element passed as argument' do
      expect([32, 43, 75, 879, 23].my_any?(23)).to be_truthy
    end
    it 'returns true if at least one of the element is not false or nil when no block is given' do
      expect([nil, false, 89, 'Microverse'].my_any?).to be_truthy
    end
  end
  describe '#my_none' do
    it 'returns true if none of the elements is true when passed to a block' do
      expect([16, 78, 12].my_none?{ |i| i.class == String }).to be_truthy
    end
    it 'returns true if none of the elements is of the same class as the class passed as argument' do
      expect(['Sam', 'John'].my_none?(Numeric)).to be_truthy
    end
    it 'returns true if none of the elements match the Regexp that passed as argument' do
      expect(['hi hello', 'hola', 'Como estas?'].my_none?(/(morning)/)).to be_truthy
    end
    it 'returns true if none of the elements match the element passed as argument' do
      expect([32, 43, 75, 879].my_none?(23)).to be_truthy
    end
    it 'returns true if none the element is true when no block is given' do
      expect([nil, false, false, nil].my_none?).to be_truthy
    end
  end
  describe '#my_count' do
    it 'returns the numbers of items in enum that passed through the given block' do
      expect([16, 78, 12, 45].my_count{ |i| i > 16}).to eq(2)
    end
    it 'returns the numbers of items in enum that is equal to the argument' do
      expect([16, 78, 12, 45].my_count(12)).to eq(1)
    end
    it 'returns the numbers of items in enum' do
      expect([16, 78, 12, 45].my_count).to eq(4)
    end
  end
  describe '#my_map' do
    it 'returns an enumarator back when no block is given' do
      expect([1, 2, 3, 4].my_map).to be_kind_of(Enumerator)
    end
    it 'returns the a new enum with the result of running each element once through the block' do
      expect([5, 7, 9].my_map{ |i| i * 2 }).to be == [10, 14, 18]
    end
  end
  describe  '#my_inject' do
    it "combines the element of the enum by passing them through the block" do
      expect([1, 2, 3, 4, 5].my_inject{ |i, j| i + j }).to eq(15)
    end
    it "combines the element of the enum by applying the operation passed as argument" do
      expect([1, 2, 3, 4, 5].my_inject(:+)).to eq(15)
    end
    it "combines the element of the enum by passing them through the block and using the integer argument as initial value " do
      expect([1, 2, 3, 4, 5].my_inject(1){ |i, j| i + j }).to eq(16)
    end
    it "combines the element of the enum by applying the operation passed as argument and using the first argument if integer as initial value" do
      expect([1, 2, 3, 4, 5].my_inject(1, :*)).to eq(120)
    end
  end
end
