module Enumerable
  # Applies a method to the collection of various arguments.
  #
  # @example Requires multiple files
  #   # Without Nutella:
  #   %w[several libs to include].each { |r| require r }
  #   # With Nutella:
  #   %w[several libs to include].apply :require
  #
  # @example Passes in multiple arguments
  #   # Without Nutella:
  #   [1, 2, 3].each { |n| foo n, 5 }
  #   # With Nutella:
  #   [1, 2, 3].apply :foo, 5
  #
  # @example Uses a multi-dimensional array to get the extra arguments
  #   arr = [[1, 2], [3, 4], [5, 6]]
  #   # Without Nutella:
  #   arr.each { |a, b| foo a, b }
  #   # With Nutella:
  #   arr.apply :foo
  #
  # @param [Symbol] method the method to apply
  # @param [*Object] args any extra arguments to use
  # @return [Array] a list of the return values of the method calls
  def apply(method, *args)
    map { |elem| send method, *elem, *args }
  end
end
