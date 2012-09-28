class String
  alias_method :contains?, :include?
  alias_method :includes?, :include?

  alias_method :each, :each_char

  # The inverse of <tt>String#include?</tt>.
  #
  # @param [String] str the string to test for exclusion
  # @return [Boolean] whether or not the string excludes the substring +str+
  def exclude?(str)
    !include? str
  end
  alias_method :excludes?, :exclude?

  # Left-aligns a heredoc by finding the least indented line in the string, and
  # removing that amount of leading whitespace from each line.
  #
  # @example Prints the contents of the heredoc as described on each line
  #   puts <<-EOS.heredoc
  #     This line would be left-aligned.
  #     This line too.
  #         This line would be indented by four spaces.
  #         As well as this line.
  #     And back to left-aligned.
  #   EOS
  #
  # @return [String] the string with excess leading whitespace stripped
  def heredoc
    gsub /^[ \t]{#{scan(/^[ \t]*(?=\S)/).min.size}}/, ""
  end
  alias_method :format_heredoc, :heredoc
  alias_method :strip_heredoc, :heredoc
end
