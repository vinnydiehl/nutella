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

    # Takes an integer input from the user. If the user does not enter a valid
    # integer value, display the error and ask them again, unless +err_msg+ is
    # <tt>nil</tt>, in which case it will not display any error message before
    # asking again. If +repeat+ is set to false, it will only ask once, exiting
    # and returning nil if the first attempt fails.
    #
    # @example Ask the user to input their age
    #   age = Nutella::int_input "Enter your age: "
    #
    # @param [String] prompt the message to display to the user
    # @param [String, NilClass] err_msg the error to show the user if they
    #                                   should enter an invalid input
    # @param [Boolean] repeat whether or not to continue prompting the user
    #                         should their first input be unacceptable
    # @return [Integer] the user's numeric input as an integer
    def int_input(prompt, err_msg = "Please enter a number.", repeat = true)
      str = ""
      until str[/^-?\d+$/]
        str = input prompt
        puts err_msg unless str[/^-?\d+$/] || err_msg.nil?
        return unless repeat
      end
      str.to_i
    end
  end
end
