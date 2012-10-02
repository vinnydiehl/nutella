module Nutella
  class << self
    # Prints the given +prompt+ to STDOUT, then reads text from STDIN until the
    # user presses Enter.
    #
    # @example Comparison of taking input with and without Nutella
    #   # Pure Ruby
    #   print "Enter your name: "
    #   name = STDIN.gets.chomp
    #
    #   # Ruby with Nutella
    #   name = Nutella::raw_input "Enter your name: "
    #
    # @param [String] prompt the message to display to the user
    # @return [String] the user's input
    def raw_input(prompt)
      print prompt
      STDIN.gets.chomp
    end

    # Takes input as described in <tt>Nutella#raw_input</tt>, but strips all
    # leading and trailing whitespace.
    #
    # @param [String] prompt the message to display to the user
    # @return [String] the user's input with excess whitespace stripped
    def input(prompt)
      raw_input(prompt).strip
    end
  end
end
