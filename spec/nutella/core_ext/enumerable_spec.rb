require "spec_helper"
require "nutella/core_ext/enumerable"

describe Enumerable do
  describe "aliases" do
    test_alias Enumerable, :contains?, :include?
    test_alias Enumerable, :includes?, :include?
    test_alias Enumerable, :excludes?, :exclude?
  end

  describe "#apply" do
    let(:testers) do
      5.times.map { ApplyTester.new(5) }
    end

    it "works for a function that takes one argument" do
      testers.apply :increment_value
      testers.map(&:value).should == [6] * 5
    end

    context "with a function that takes two arguments" do
      it "allows multi-dimensional arrays" do
        multi = testers.zip([2] * 5)
        multi.apply :increment_value
        multi.each { |arr| arr.first.value.should == 7 }
      end

      it "allows multiple arguments" do
        testers.apply :increment_value, 2
        testers.map(&:value).should == [7] * 5
      end
    end

    context "with a function that takes many arguments" do
      it "allows multi-dimensional arrays" do
        multi = testers.map { |elem| [elem, 2, 2] }
        multi.apply :increment_value
        multi.each { |arr| arr.first.value.should == 9 }
      end

      it "allows multiple arguments" do
        testers.apply :increment_value, 2, 2
        testers.map(&:value).should == [9] * 5
      end

      it "allows multi-dimensional arrays with multiple arguments" do
        multi = testers.zip([2] * 5)
        multi.apply :increment_value, 2
        multi.each { |arr| arr.first.value.should == 9 }
      end
    end
  end

  describe "#exclude?" do
    it "returns true if the collection does not contain the input" do
      [1, 2, 3].exclude?(4).should be_true
    end

    it "returns false if the collection contains the input" do
      [1, 2, 3].exclude?(2).should be_false
    end
  end

  describe "#group" do
    it "groups elements" do
      [].group(2).should == []
      [1, 2].group(2).should == [[1, 2]]
      (1..4).group(2).should == [[1, 2], [3, 4]]
      (1..9).group(3).should == [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    end

    it "puts all excess into the last group" do
      [1, 2].group(4).should == [[1, 2]]
      (1..8).group(3).should == [[1, 2, 3], [4, 5, 6], [7, 8]]
    end

    it "discards all excess if instructed to" do
      (1..3).group(2, true).should == [[1, 2]]
      (1..8).group(3, true).should == [[1, 2, 3], [4, 5, 6]]
    end

    it "does not discard anything if there is no excess" do
      (1..4).group(2, true).should == [[1, 2], [3, 4]]
    end

    it "does not modify in place" do
      arr = (1..10).to_a
      arr.group 2
      arr.should == (1..10).to_a
    end
  end

  describe "#group!" do
    let(:arr) { (1..10).to_a }

    it "modifies in place" do
      expect { arr.group! 2 }.to change { arr }.to (1..10).group(2)
    end

    it "returns the modified string" do
      arr.group!(2).should == arr
    end

    it "returns nil if nothing was modified" do
      [].group!(2).should be_nil
    end
  end

  describe "#map" do
    it "takes a symbol and maps that method" do
      [1, 2, 3].map(:succ).should == [2, 3, 4]
      (1..10).map(:succ).should == (2..11).to_a
    end

    it "passes additional arguments into the method in the first argument" do
      arr = %w[Alice Bob Charlie Dennis]
      alpha = ("a".."z")
      args = [/[aeiou]/, "x"]

      arr.map(:gsub, *args).should == arr.map { |e| e.gsub *args }
      alpha.map(:gsub, *args).should == alpha.map { |e| e.gsub *args }
    end

    context "when using as the original #map" do
      it "doesn't break passing in blocks" do
        [1, 2, 3].map { |n| n + 1 }.should == [2, 3, 4]
      end

      it "doesn't break when passing in Proc" do
        [1, 2, 3].map(&:succ).should == [2, 3, 4]
      end
    end
  end

  describe "#sum" do
    it "returns the sum of elements" do
      [].sum.should == 0
      [5].sum.should == 5
      [1, 2, 3].sum.should == 6
      (1..4).sum.should == 10
    end

    it "flattens the elements before adding" do
      [[4, 5], 1].sum.should == 10
      [[1, 2, 3], [4, 5]].sum.should == 15
    end

    it "filters out all non-numbers" do
      { a: 2, b: 4 }.sum.should == 6
      [1, "str", 4].sum.should == 5
      ["no numbers"].sum.should == 0
    end

    context "with a block" do
      it "returns the sum of the elements that pass the filter block" do
        (1..10).sum(&:even?).should == 30
        (1..10).sum { |n| n % 3 == 0 }.should == 18
      end

      it "still filters out all non-numbers" do
        { a: 1, b: 2, c: 3 }.sum(&:odd?).should == 4
        [2, "str", 4, 7].sum(&:even?).should == 6
      end
    end
  end
end
