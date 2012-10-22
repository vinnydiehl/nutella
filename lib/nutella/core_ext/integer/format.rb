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
    suffixes = { 1 => "st", 2 => "nd", 3 => "rd" }

    self.to_s + if (11..13).include?(self.abs % 100)
      "th"
    elsif suffixes.keys.include? (last_digit = self.abs % 10)
      suffixes[last_digit]
    else
      "th"
    end
  end
end
