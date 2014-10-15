module Enumerable
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
end
