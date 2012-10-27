module Enumerable
  alias_method :contains?, :include?
  alias_method :includes?, :include?

  # The inverse of <tt>Enumerable#include?</tt>.
  #
  # @param [Object] object the object to test for exclusion
  # @return [Boolean] whether or not the collection excludes +object+
  def exclude?(object)
    !include? object
  end
  alias_method :excludes?, :exclude?
end
