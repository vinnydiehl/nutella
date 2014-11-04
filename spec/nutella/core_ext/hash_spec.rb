require "spec_helper"
require "nutella/core_ext/hash"

describe Hash do
  let(:hash) { {a: 1, b: 2, c: 3, d: 4} }

  describe "aliases" do
    test_alias Hash, :slice, :grab
    test_alias Hash, :slice!, :grab!
  end

  describe "#grab" do
    it "selects the given items from a hash" do
      expect(hash.slice(:a, :c)).to eq({a: 1, c: 3})
    end

    it "skips items that do not exist in the hash" do
      expect(hash.slice(:a, :d, :f)).to eq({a: 1, d: 4})
    end

    it "does not modify in place" do
      start = hash
      hash.slice :a, :b
      expect(hash).to eq(start)
    end
  end

  describe "#grab!" do
    it "modifies in place" do
      expect { hash.slice! :a, :c }.to change { hash }.to({a: 1, c: 3})
    end

    it "returns the removed pairs" do
      expect(hash.slice!(:a, :c)).to eq({b: 2, d: 4})
    end

    it "does not return pairs that did not affect the hash" do
      expect(hash.slice!(:a, :c, :g)).to eq({b: 2, d: 4})
    end
  end
end
