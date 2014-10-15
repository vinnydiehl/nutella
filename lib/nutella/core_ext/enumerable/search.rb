module Enumerable
  alias contains? include?
  alias includes? include?

  # The inverse of <tt>Enumerable#include?</tt>.
  #
  # @param [Object] object the object to test for exclusion
  # @return [Boolean] whether or not the collection excludes +object+
  def exclude?(object)
    !include? object
  end
  alias excludes? exclude?
end
