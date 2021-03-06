class String
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
  alias format_heredoc heredoc
  alias strip_heredoc heredoc
end
