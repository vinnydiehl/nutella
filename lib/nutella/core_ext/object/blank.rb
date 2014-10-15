class Object
  # Returns true if the object is false, empty, or a whitespace string.
  #
  #   nil.blank?    # => true
  #   false.blank?  # => true
  #   4.blank?      # => false
  #
  # @example Compare with and without usage of Object#blank?
  #   # Without:
  #   if str.nil? || str.empty?
  #   # With:
  #   if str.blank?
  #
  # @return [Boolean] whether or not the object is blank
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end

  # The inverse of Object#blank?.
  #
  # @return [Boolean] whether or not the object is not blank
  def present?
    !blank?
  end

  # Returns the object if it is present, returns <tt>nil</tt> if the object is
  # blank.
  #
  #   "str".presence  # => "str"
  #   "".presence     # => nil
  #
  # @return [Object, NilClass] the object if present, otherwise nil
  def presence
    self if present?
  end
end

class String #:nodoc:
  def blank?
    self !~ /[^\s]/
  end
end
