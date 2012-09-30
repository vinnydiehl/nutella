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

  describe "#group" do
    it "should group elements" do
      [].group(2).should == []
      [1, 2].group(2).should == [[1, 2]]
      (1..4).group(2).should == [[1, 2], [3, 4]]
      (1..9).group(3).should == [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    end

    it "should put all excess into the last group" do
      [1, 2].group(4).should == [[1, 2]]
      (1..8).group(3).should == [[1, 2, 3], [4, 5, 6], [7, 8]]
    end

    it "should discard all excess if instructed to" do
      (1..3).group(2, true).should == [[1, 2]]
      (1..8).group(3, true).should == [[1, 2, 3], [4, 5, 6]]
    end

    it "should not discard anything if there is no excess" do
      (1..4).group(2, true).should == [[1, 2], [3, 4]]
    end

    it "should not modify in place" do
      arr = (1..10).to_a
      arr.group 2
      arr.should == (1..10).to_a
    end
  end

  describe "#group!" do
    arr = []

    before { arr = (1..10).to_a }

    it "should modify in place" do
      arr.group! 2
      arr.should == (1..10).group(2)
    end

    it "should return the modified string" do
      return_catcher = arr.group! 2
      return_catcher.should == arr
    end

    it "should return nil if nothing was modified" do
      return_catcher = [].group! 2
      return_catcher.should be_nil
    end
  end

  describe "#sum" do
    it "should return the sum of elements" do
      [].sum.should == 0
      [5].sum.should == 5
      [1, 2, 3].sum.should == 6
      (1..4).sum.should == 10
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

    context "with a block" do
      it "should return the sum of the elements that pass the filter block" do
        (1..10).sum(&:even?).should == 30
        (1..10).sum { |n| n % 3 == 0 }.should == 18
      end

      it "should still filter out all non-numbers" do
        { a: 1, b: 2, c: 3 }.sum(&:odd?).should == 4
        [2, "str", 4, 7].sum(&:even?).should == 6
      end
    end
  end
end
