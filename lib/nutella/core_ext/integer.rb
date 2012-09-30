class Integer
  # Check whether the integer is evenly divisible by all of the arguments.
  #
  # @example Check if some numbers are evenly divisible by 5
  #   4.multiple_of? 5   # => false
  #   30.multiple_of? 5  # => true
  #
  # @example Check if some numbers are evenly divisible by both 4 and 7
  #   10.multiple_of? 4, 7  # => false
  #   56.multiple_of? 4, 7  # => true
  #
  # @param [*Integer] nums the integer(s) to check against
  # @return [Boolean] whether or not the integer is evenly divisible by all
  #                   arguments
  def multiple_of?(*nums)
    nums.all? { |n| (!n.zero? && self % n == 0) || zero? }
  end
  alias_method :divisible_by?, :multiple_of?

  # Check whether the integer is evenly divisible by any of the arguments.
  #
  # @example {Project Euler #1}[http://projecteuler.net/problem=1] solution using Nutella
  #   (1...1000).sum { |n| n.multiple_of_any?(3, 5) }
  #
  # @param [*Integer] nums the integer(s) to check against
  # @return [Boolean] whether or not the integer is evenly divisible by any
  #                   arguments
  def multiple_of_any?(*nums)
    nums.any? { |n| multiple_of? n }
  end
  alias_method :divisible_by_any?, :multiple_of_any?
end
