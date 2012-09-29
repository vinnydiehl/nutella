class Hash
  # Grab the given keys out of a hash.
  #
  # @example Selects two keys out of a hash
  #   { a: 1, b: 2, c: 3, d: 4 }.slice :a, :c  # => { a: 1, c: 3 }
  #
  # @example Limits an options hash to valid keys before passing to a method
  #   def search(criteria = {})
  #     criteria.assert_valid_keys(:mass, :velocity, :time)
  #   end
  #
  #   search(options.slice(:mass, :velocity, :time))def slice(*keys)
  #
  # @example Splats an array of keys before passing to the #search method above
  #   valid_keys = [:mass, :velocity, :time]
  #   search(options.slice(*valid_keys))
  #
  # @param [*Object] keys the keys to slice out of the hash
  # @return [Hash] the key/value pairs that exist in *keys
  def slice(*keys)
    select { |k, v| keys.include? k }
  end
  alias_method :grab, :slice

  # Acts on the hash as described in Hash#slice, but modifies the hash in
  # place.
  #
  # @example Demonstrates the action and its return value
  #   test = { a: 1, b: 2, c: 3, d: 4 }
  #   test.slice! :a, :c  # => { b: 2, d: 4 }
  #   test                # => { a: 1, c: 3 }
  #
  # @param [*Object] keys the keys to slice out of the hash
  # @return [Hash] the removed key/value pairs
  def slice!(*keys)
    replace((original = self.dup).slice *keys)
    original.reject { |k, v| keys.include? k }
  end
  # #grab! doesn't sound quite semantically correct, but keeping it for the
  # sake of being consistent with #slice/#grab.
  alias_method :grab!, :slice!
end
