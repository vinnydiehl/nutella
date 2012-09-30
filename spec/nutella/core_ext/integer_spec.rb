require "spec_helper"
require "nutella/core_ext/integer"

describe Integer do
  describe "aliases" do
    test_alias Integer, :divisible_by?, :multiple_of?
    test_alias Integer, :divisible_by_any?, :multiple_of_any?
  end

  describe "#multiple_of?" do
    it "should return true if the number is evenly divisible" do
      5.multiple_of?(5).should be_true
      15.multiple_of?(5).should be_true
      10.multiple_of?(2).should be_true
      6000.multiple_of?(6).should be_true
    end

    it "should return false if the number is not evenly divisible" do
      20.multiple_of?(7).should be_false
      4.multiple_of?(3).should be_false
      5.multiple_of?(15).should be_false
      100.multiple_of?(3).should be_false
    end

    context "when passing in zero" do
      it "should return false if one tries to divide by zero" do
        20.multiple_of?(0).should be_false
        30.multiple_of?(0).should be_false
      end

      it "should allow zero to go into zero" do
        0.multiple_of?(0).should be_true
      end
    end

    context "with multiple arguments" do
      it "should return true if evenly divisible by all arguments" do
        15.multiple_of?(3, 15).should be_true
        100.multiple_of?(2, 5, 25).should be_true
        0.multiple_of?(0, 1, 2).should be_true
      end

      it "should return false if evenly divisible by only some arguments" do
        15.multiple_of?(2, 3).should be_false
        12.multiple_of?(3, 4, 6, 8).should be_false
        10.multiple_of?(0, 5).should be_false
      end

      it "should return false if evenly divisible by none of the arguments" do
        6.multiple_of?(4, 5).should be_false
        17.multiple_of?(2, 4).should be_false
      end
    end
  end

  describe "#multiple_of_any?" do
    it "should return true if evenly divisible by all arguments" do
      15.multiple_of_any?(3, 15).should be_true
      100.multiple_of_any?(2, 5, 25).should be_true
      0.multiple_of_any?(0, 1, 2).should be_true
    end

    it "should return true if evenly divisible by only some arguments" do
      15.multiple_of_any?(2, 3).should be_true
      12.multiple_of_any?(3, 4, 6, 8).should be_true
      10.multiple_of_any?(0, 5).should be_true
    end

    it "should return false if evenly divisible by none of the arguments" do
      6.multiple_of_any?(4, 5).should be_false
      17.multiple_of_any?(2, 4).should be_false
    end
  end
end
