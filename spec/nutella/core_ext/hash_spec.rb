require "spec_helper"
require "nutella/core_ext/hash"

describe Hash do
  let(:hash) { { a: 1, b: 2, c: 3, d: 4 } }

  describe "aliases" do
    test_alias Hash, :slice, :grab
    test_alias Hash, :slice!, :grab!
  end

  describe "#grab" do
    it "selects the given items from a hash" do
      hash.slice(:a, :c).should == { a: 1, c: 3 }
    end

    it "skips items that do not exist in the hash" do
      hash.slice(:a, :d, :f).should == { a: 1, d: 4 }
    end

    it "does not modify in place" do
      start = hash
      hash.slice :a, :b
      hash.should == start
    end
  end

  describe "#grab!" do
    it "modifies in place" do
      hash.slice! :a, :c
      hash.should == { a: 1, c: 3 }
    end

    it "returns the removed pairs" do
      hash.slice!(:a, :c).should == { b: 2, d: 4 }
    end

    it "ignores pairs that did not affect the hash" do
      hash.slice!(:a, :c, :g).should == { b: 2, d: 4 }
      hash.should == { a: 1, c: 3 }
    end
  end
end
