class Integer
  # Returns a string with the ordinal form of the integer.
  #
  #   1.ordinalize   # => "1st"
  #   2.ordinalize   # => "2nd"
  #   9.ordinalize   # => "9th"
  #   43.ordinalize  # => "43rd"
  #
  # @return [String] the ordinal form of the integer
  def ordinalize
    self.to_s + if abs % 100 / 10 != 1 && (1..3).include?(last = abs % 10)
      {1 => "st", 2 => "nd", 3 => "rd"}[last]
    else
      "th"
    end
  end
end
