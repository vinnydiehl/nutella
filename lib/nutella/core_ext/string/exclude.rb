class String
  # The inverse of <tt>String#include?</tt>.
  #
  # @param [String] str the string to test for exclusion
  # @return [Boolean] whether or not the string excludes the substring +str+
  def exclude?(str)
    !include? str
  end
  alias excludes? exclude?
end
