module Enumerable
  # Add together all numeric elements in the collection. When using a block,
  # adds together all numeric elements that pass the predicate in that block.
  #
  # @example Sums up the elements of an array
  #   [1, 2, 3].sum         # => 6
  # @example Sums up the elements of a 2-dimensional array
  #   [[1, 2], [3, 4]].sum  # => 10
  # @example Sums up the numeric elements of a hash
  #   { a: 4, b: 5 }.sum    # => 9
  # @example Ignores the non-numeric element in the array
  #   [2, "string", 9].sum  # => 11
  # @example Sums up the even numbers from 1 to 10
  #   (1..10).sum &:even?
  # @example Sums up the numbers from 1 to 100 that are multiples of 3
  #   (1..100).sum { |n| n % 3 == 0 }
  #
  # @return [Numeric] the sum of all numeric elements in the collection
  def sum(&block)
    # TODO: Two selects in a row, how to DRY this up?
    flat = respond_to?(:flatten) ? flatten : self
    flat.select { |e| e.is_a? Numeric }.select(&block).inject(:+) || 0
  end
end
