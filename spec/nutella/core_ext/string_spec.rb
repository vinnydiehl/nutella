require "spec_helper"
require "nutella/core_ext/string"

describe Enumerable do
  describe "aliases" do
    test_alias String, :contains?, :include?
    test_alias String, :includes?, :include?
    test_alias String, :excludes?, :exclude?

    test_alias String, :each, :each_char

    test_alias String, :format_heredoc, :heredoc
    test_alias String, :strip_heredoc, :heredoc
  end

  describe "#exclude?" do
    it "returns true if the string does not contain the input string" do
      "hello".exclude?("test").should be_true
    end

    it "returns false if the string contains the input string" do
      "hello".exclude?("llo").should be_false
    end
  end

  describe "#heredoc" do
    test = expected = ""

    let(:test) do <<-EOS.heredoc
        This is a test of String#heredoc.
        This text should be left-aligned.
            This text is indented by four spaces.
           now three spaces...
          now two spaces...
         now one space...
        Left-aligned again.
      EOS
    end

    let(:expected) do <<EOS
This is a test of String#heredoc.
This text should be left-aligned.
    This text is indented by four spaces.
   now three spaces...
  now two spaces...
 now one space...
Left-aligned again.
EOS
    end

    it "strips all excess whitespace from the left" do
      test.should == expected
    end
  end
end
