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
      expect(testers.map(&:value)).to eq([6] * 5)
    end

    context "with a function that takes two arguments" do
      it "allows multi-dimensional arrays" do
        multi = testers.zip([2] * 5)
        multi.apply :increment_value
        multi.each { |arr| expect(arr.first.value).to eq(7) }
      end

      it "allows multiple arguments" do
        testers.apply :increment_value, 2
        expect(testers.map(&:value)).to eq([7] * 5)
      end
    end

    context "with a function that takes many arguments" do
      it "allows multi-dimensional arrays" do
        multi = testers.map { |elem| [elem, 2, 2] }
        multi.apply :increment_value
        multi.each { |arr| expect(arr.first.value).to eq(9) }
      end

      it "allows multiple arguments" do
        testers.apply :increment_value, 2, 2
        expect(testers.map(&:value)).to eq([9] * 5)
      end

      it "allows multi-dimensional arrays with multiple arguments" do
        multi = testers.zip([2] * 5)
        multi.apply :increment_value, 2
        multi.each { |arr| expect(arr.first.value).to eq(9) }
      end
    end
  end

  describe "#exclude?" do
    it "returns true if the collection does not contain the input" do
      expect([1, 2, 3].exclude?(4)).to be_truthy
    end

    it "returns false if the collection contains the input" do
      expect([1, 2, 3].exclude?(2)).to be_falsey
    end
  end

  describe "#group" do
    it "groups elements" do
      expect([].group(2)).to eq([])
      expect([1, 2].group(2)).to eq([[1, 2]])
      expect((1..4).group(2)).to eq([[1, 2], [3, 4]])
      expect((1..9).group(3)).to eq([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    end

    it "puts all excess into the last group" do
      expect([1, 2].group(4)).to eq([[1, 2]])
      expect((1..8).group(3)).to eq([[1, 2, 3], [4, 5, 6], [7, 8]])
    end

    it "discards all excess if instructed to" do
      expect((1..3).group(2, true)).to eq([[1, 2]])
      expect((1..8).group(3, true)).to eq([[1, 2, 3], [4, 5, 6]])
    end

    it "does not discard anything if there is no excess" do
      expect((1..4).group(2, true)).to eq([[1, 2], [3, 4]])
    end

    it "does not modify in place" do
      arr = (1..10).to_a
      arr.group 2
      expect(arr).to eq((1..10).to_a)
    end
  end

  describe "#group!" do
    let(:arr) { (1..10).to_a }

    it "modifies in place" do
      expect { arr.group! 2 }.to change { arr }.to (1..10).group(2)
    end

    it "returns the modified string" do
      expect(arr.group!(2)).to eq(arr)
    end

    it "returns nil if nothing was modified" do
      expect([].group!(2)).to be_nil
    end
  end

  describe "#map" do
    it "takes a symbol and maps that method" do
      expect([1, 2, 3].map(:succ)).to eq([2, 3, 4])
      expect((1..10).map(:succ)).to eq((2..11).to_a)
    end

    it "passes additional arguments into the method in the first argument" do
      arr = %w[Alice Bob Charlie Dennis]
      alpha = ("a".."z")
      args = [/[aeiou]/, "x"]

      expect(arr.map(:gsub, *args)).to eq(arr.map { |e| e.gsub *args })
      expect(alpha.map(:gsub, *args)).to eq(alpha.map { |e| e.gsub *args })
    end

    context "when using as the original #map" do
      it "doesn't break passing in blocks" do
        expect([1, 2, 3].map { |n| n + 1 }).to eq([2, 3, 4])
      end

      it "doesn't break when passing in Proc" do
        expect([1, 2, 3].map(&:succ)).to eq([2, 3, 4])
      end
    end
  end

  describe "#sum" do
    it "returns the sum of elements" do
      expect([].sum).to eq(0)
      expect([5].sum).to eq(5)
      expect([1, 2, 3].sum).to eq(6)
      expect((1..4).sum).to eq(10)
    end

    it "flattens the elements before adding" do
      expect([[4, 5], 1].sum).to eq(10)
      expect([[1, 2, 3], [4, 5]].sum).to eq(15)
    end

    it "filters out all non-numbers" do
      expect({ a: 2, b: 4 }.sum).to eq(6)
      expect([1, "str", 4].sum).to eq(5)
      expect(["no numbers"].sum).to eq(0)
    end

    context "with a block" do
      it "returns the sum of the elements that pass the filter block" do
        expect((1..10).sum(&:even?)).to eq(30)
        expect((1..10).sum { |n| n % 3 == 0 }).to eq(18)
      end

      it "still filters out all non-numbers" do
        expect({ a: 1, b: 2, c: 3 }.sum(&:odd?)).to eq(4)
        expect([2, "str", 4, 7].sum(&:even?)).to eq(6)
      end
    end
  end
end
