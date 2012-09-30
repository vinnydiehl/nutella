module Enumerable
  alias_method :contains?, :include?
  alias_method :includes?, :include?

  # The inverse of <tt>Enumerable#include?</tt>.
  #
  # @param [Object] object the object to test for exclusion
  # @return [Boolean] whether or not the collection excludes +object+
  def exclude?(object)
    !include? object
  end
  alias_method :excludes?, :exclude?

  # Groups an array into smaller arrays of +size+ elements. Remaining elements
  # at the end will be put into a smaller group if necessary, unless
  # +discard_excess+ is true, in which case they will be discarded.
  #
  # @example Groups numbers 1..4 into groups of 2
  #   (1..4).group(2)       # => [[1, 2], [3, 4]]
  # @example Groups numbers 1..8 into groups of 3
  #   (1..8).group(3)       # => [[1, 2, 3], [4, 5, 6], [7, 8]]
  # @example Groups numbers 1..8 into groups of 3, discarding excess elements
  #   (1..8).group(3, true) # => [[1, 2, 3], [4, 5, 6]]
  #
  # @param [Integer] size the size of the groups to create
  # @param [Boolean] discard_excess whether or not to discard extra elements
  # @return [Array] an array of the groups
  def group(size, discard_excess = false)
    groups = each_slice(size).to_a
    groups[0..(discard_excess && groups.last.size < size ? -2 : -1)]
  end

  # Modifies the collection in place as described for
  # <tt>Enumerable#group</tt>. Returns the modified collection, or nil if no
  # modifications were made.
  #
  # @see Enumerable#group
  def group!(size, discard_excess = false)
    return nil if empty?
    self.replace group(size, discard_excess)
  end

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
