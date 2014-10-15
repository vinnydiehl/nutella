module Enumerable
  alias old_map map

  # Allows mapping of a method with parameters across a collection.
  #
  # You no longer have to open up a block just because the method that you're
  # mapping needs parameters. This method is still behaves just as it used to
  # otherwise.
  #
  # @example Replaces all vowels with <tt>"x"</tt> in a list of strings
  #   %w[Ann Mary Paul].map :gsub, /[aeiou]/i, "x" # => ["xnn", "Mxry", "Pxul"]
  def map(*args, &block)
    block_given? ? old_map(&block) : old_map { |elem| elem.send *args }
  end
end

# TODO: See if there is a DRYer way to make this work with Array also.
# Array doesn't inherit Enumerable's #map, so I'm forced to do this. Is there a
# better way to make Array inherit the modified #map?

class Array
  alias old_map map

  # Allows mapping of a method with parameters across an array.
  #
  # @see Enumerable#map
  def map(*args, &block)
    block_given? ? old_map(&block) : old_map { |elem| elem.send *args }
  end
end
