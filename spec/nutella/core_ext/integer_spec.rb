require "spec_helper"
require "nutella/core_ext/integer"

describe Integer do
  describe "aliases" do
    test_alias Integer, :divisible_by?, :multiple_of?
    test_alias Integer, :divisible_by_any?, :multiple_of_any?
  end

  describe "#digits" do
    it "returns an array of the digits in the integer" do
      (0..9).each { |n| n.digits.should == [n] }
      10.digits.should == [1, 0]
      349.digits.should == [3, 4, 9]
      1000.digits.should == [1, 0, 0, 0]
    end

    it "trims the '-' from negative numbers" do
      -3.digits.should == [3]
      -20.digits.should == [2, 0]
    end
  end

  describe "#ordinalize" do
    NUMBER_FORMATS.each do |cardinal, ordinal|
      it "returns the ordinal #{ordinal} for the integer #{cardinal}" do
        cardinal.ordinalize.should == ordinal
      end
    end
  end

  describe "#goes_into?" do
    it "returns true if the number goes evenly into the argument" do
      5.goes_into?(10).should be_true
      3.goes_into?(21).should be_true
      25.goes_into?(100).should be_true
    end

    it "returns false if the number does not go evenly in" do
      3.goes_into?(10).should be_false
      9.goes_into?(40).should be_false
      10.goes_into?(5).should be_false
    end

    context "when passing in zero" do
      it "returns false if one tries to divide by zero" do
        0.goes_into?(20).should be_false
        0.goes_into?(30).should be_false
      end

      it "allows zero to go into zero" do
        0.goes_into?(0).should be_true
      end
    end

    context "with multiple arguments" do
      it "returns true if all arguments succeed" do
        5.goes_into?(10, 15, 50).should be_true
        2.goes_into?(2, 4, 10).should be_true
      end

      it "returns false if only some arguments succeed" do
        5.goes_into?(10, 12, 15).should be_false
        8.goes_into?(4, 16).should be_false
      end

      it "returns false if no arguments succeed" do
        3.goes_into?(8, 16, 20).should be_false
        6.goes_into?(5, 10, 15).should be_false
      end
    end
  end

  describe "#goes_into_any?" do
    it "returns true if all arguments succeed" do
      5.goes_into_any?(10, 15, 50).should be_true
      2.goes_into_any?(2, 4, 10).should be_true
    end

    it "returns true if only some arguments succeed" do
      5.goes_into_any?(10, 12, 15).should be_true
      8.goes_into_any?(4, 16).should be_true
    end

    it "returns false if no arguments succeed" do
      3.goes_into_any?(8, 16, 20).should be_false
      6.goes_into_any?(5, 10, 15).should be_false
    end
  end

  describe "#multiple_of?" do
    it "returns true if the number is evenly divisible" do
      5.should be_multiple_of(5)
      15.should be_multiple_of(5)
      10.should be_multiple_of(2)
      6000.should be_multiple_of(6)
    end

    it "returns false if the number is not evenly divisible" do
      20.should_not be_multiple_of(7)
      4.should_not be_multiple_of(3)
      5.should_not be_multiple_of(15)
      100.should_not be_multiple_of(3)
    end

    context "when passing in zero" do
      it "returns false if one tries to divide by zero" do
        20.should_not be_multiple_of(0)
        30.should_not be_multiple_of(0)
      end

      it "allows zero to go into zero" do
        0.should be_multiple_of(0)
      end
    end

    context "with multiple arguments" do
      it "returns true if evenly divisible by all arguments" do
        15.should be_multiple_of(3, 15)
        100.should be_multiple_of(2, 5, 25)
        0.should be_multiple_of(0, 1, 2)
      end

      it "returns false if evenly divisible by only some arguments" do
        15.should_not be_multiple_of(2, 3)
        12.should_not be_multiple_of(3, 4, 6, 8)
        10.should_not be_multiple_of(0, 5)
      end

      it "returns false if evenly divisible by none of the arguments" do
        6.should_not be_multiple_of(4, 5)
        17.should_not be_multiple_of(2, 4)
      end
    end
  end

  describe "#multiple_of_any?" do
    it "returns true if evenly divisible by all arguments" do
      15.should be_multiple_of_any(3, 15)
      100.should be_multiple_of_any(2, 5, 25)
      0.should be_multiple_of_any(0, 1, 2)
    end

    it "returns true if evenly divisible by only some arguments" do
      15.should be_multiple_of_any(2, 3)
      12.should be_multiple_of_any(3, 4, 6, 8)
      10.should be_multiple_of_any(0, 5)
    end

    it "returns false if evenly divisible by none of the arguments" do
      6.should_not be_multiple_of_any(4, 5)
      17.should_not be_multiple_of_any(2, 4)
    end
  end
end
