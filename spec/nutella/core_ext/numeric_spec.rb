require "spec_helper"
require "nutella/core_ext/numeric"

describe Numeric do
  describe "aliases" do
    # Test the singular aliases- byte for bytes, kilobyte for kilobytes, etc.
    ([""] + %w[kilo mega giga tera peta exa]).each do |prefix|
      test_alias Numeric, (name = "#{prefix}byte").to_sym, "#{name}s".to_sym
    end
  end

  describe "#percent" do
    it "returns the percent for an integer" do
      expect(5.percent).to eq(0.05)
      expect(15.percent).to eq(0.15)
      expect(50.percent).to eq(0.5)
      expect(125.percent).to eq(1.25)
    end

    it "returns an integer for multiples of 100" do
      expect(100.percent).to eq(1)
      expect(500.percent).to eq(5)
    end

    it "returns the percent for a floating point" do
      expect(0.5.percent).to eq(0.005)
      expect(5.5.percent).to eq(0.055)
      expect(10.5.percent).to eq(0.105)
    end

    it "returns an integer for floating point multiples of 100" do
      expect(100.0.percent).to eq(1)
    end

    it "returns zero for 0" do
      expect(0.percent).to be_zero
    end
  end

  describe "#sanity_check_min" do
    it "returns the parameter if the number is lower" do
      expect(5.sanity_check_min(7)).to eq(7)
    end

    it "doesn't change anything if the number is equal" do
      expect(5.sanity_check_min(5)).to eq(5)
    end

    it "returns the number if the number is higher" do
      expect(5.sanity_check_min(2)).to eq(5)
    end
  end

  describe "#sanity_check_max" do
    it "returns the parameter if the number is higher" do
      expect(5.sanity_check_max(2)).to eq(2)
    end

    it "doesn't change anything if the number is equal" do
      expect(5.sanity_check_max(5)).to eq(5)
    end

    it "returns the number if the number is lower" do
      expect(5.sanity_check_max(7)).to eq(5)
    end
  end
end
