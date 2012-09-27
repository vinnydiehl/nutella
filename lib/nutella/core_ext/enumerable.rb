module Enumerable
  alias_method :contains?, :include?
  alias_method :includes?, :include?

  # The inverse of <tt>Enumerable#include?</tt>. Returns +true+ if the
  # collection does not contain +object+.
  def exclude? object
    !include? object
  end
  alias_method :excludes?, :exclude?

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
