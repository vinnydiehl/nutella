class Numeric
  # Translates a percentage number to a decimal.
  #
  #   5.percent    # => 0.05
  #   20.percent   # => 0.2
  #   25.percent   # => 0.25
  #   125.percent  # => 1.25
  #   100.percent  # => 1
  #   200.percent  # => 2
  #
  # @return [Numeric] the decimal for the percentage number
  def percent
    self / 100.0
  end
end
