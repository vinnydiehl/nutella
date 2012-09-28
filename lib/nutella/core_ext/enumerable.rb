module Enumerable
  alias_method :contains?, :include?
  alias_method :includes?, :include?

  # The inverse of <tt>Enumerable#include?</tt>. Returns +true+ if the
  # collection does not contain +object+.
  def exclude? object
    !include? object
  end
  alias_method :excludes?, :exclude?

  # Groups an array into smaller arrays of +size+ elements. Remaining elements
  # at the end will be put into a smaller group if necessary, unless
  # +discard_excess+ is true, in which case they will be discarded.
  #
  #   (1..4).group(2)       # => [[1, 2], [3, 4]]
  #   (1..8).group(3)       # => [[1, 2, 3], [4, 5, 6], [7, 8]]
  #   (1..8).group(3, true) # => [[1, 2, 3], [4, 5, 6]]
  def group(size, discard_excess = false)
    groups = each_slice(size).to_a
    discard_excess && groups.last.size < size ? groups[0..-2] : groups
  end

  # Modifies the collection in place as described for
  # <tt>Enumerable#group</tt>. Returns the modified collection, or nil if no
  # modifications were made.
  def group!(size, discard_excess = false)
    return nil if empty?
    self.replace group(size, discard_excess)
  end

  # Returns the sum of all numeric elements in the collection
  #
  #   [1, 2, 3].sum         # => 6
  #   [[1, 2], [3, 4]].sum  # => 10
  #   { a: 4, b: 5 }.sum    # => 9
  #   [2, "string", 9].sum  # => 11
  def sum
    flatten.select { |e| e.is_a? Numeric }.inject(:+) || 0
  end
end
