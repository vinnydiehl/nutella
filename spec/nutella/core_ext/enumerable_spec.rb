require "spec_helper"
require "nutella/core_ext/enumerable"

describe Enumerable do
  describe "aliases" do
    test_alias Enumerable, :contains?, :include?
    test_alias Enumerable, :includes?, :include?
    test_alias Enumerable, :excludes?, :exclude?
  end

  describe "#exclude?" do
    it "should return true if the collection does not contain the input" do
      [1, 2, 3].exclude?(4).should be_true
    end

    it "should return false if the collection contains the input" do
      [1, 2, 3].exclude?(2).should be_false
    end
  end

  describe "#sum" do
    it "should return the sum of elements" do
      [].sum.should == 0
      [5].sum.should == 5
      [1, 2, 3].sum.should == 6
    end

    it "should flatten the elements before adding" do
      [[4, 5], 1].sum.should == 10
      [[1, 2, 3], [4, 5]].sum.should == 15
    end

    it "should filter out all non-numbers" do
      { a: 2, b: 4 }.sum.should == 6
      [1, "str", 4].sum.should == 5
      ["no numbers"].sum.should == 0
    end
  end
end
