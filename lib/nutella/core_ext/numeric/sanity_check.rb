class Numeric
  # Checks that the number is at least a given minimum.
  #
  # @example Makes sure that a variable +num+ is a minimum of 5
  #   num = num.sanity_check_min 5
  #
  # @param [Numeric] minimum the minimum that the number can be
  # @return [Numeric] what the number must be in order to satisfy the minimum
  def sanity_check_min(minimum)
    [self, minimum].max
  end

  # Checks that the number is at most a given maximum.
  #
  # @example Makes sure that a variable +num+ is a maximum of 5
  #   num = num.sanity_check_max 5
  #
  # @param [Numeric] maximum the maximum that the number can be
  # @return [Numeric] what the number must be in order to satisfy the maximum
  def sanity_check_max(maximum)
    [self, maximum].min
  end
end
