class Integer
  # Returns an array of integers containing the digits of the integer. The
  # <tt>"-"</tt> will be trimmed if the number is negative.
  #
  #   120.digits  # => [1, 2, 0]
  #   -35.digits  # => [3, 5]
  #
  # @return [Array] the digits of the number as integers
  def digits
    abs.to_s.chars.map &:to_i
  end
end
