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
      5.percent.should == 0.05
      15.percent.should == 0.15
      50.percent.should == 0.5
      125.percent.should == 1.25
    end

    it "returns an integer for multiples of 100" do
      100.percent.should == 1
      500.percent.should == 5
    end

    it "returns the percent for a floating point" do
      0.5.percent.should == 0.005
      5.5.percent.should == 0.055
      10.5.percent.should == 0.105
    end

    it "returns an integer for floating point multiples of 100" do
      100.0.percent.should == 1
    end

    it "returns zero for 0" do
      0.percent.should be_zero
    end
  end

  describe "#sanity_check_min" do
    it "returns the parameter if the number is lower" do
      5.sanity_check_min(7).should == 7
    end

    it "doesn't change anything if the number is equal" do
      5.sanity_check_min(5).should == 5
    end

    it "returns the number if the number is higher" do
      5.sanity_check_min(2).should == 5
    end
  end

  describe "#sanity_check_max" do
    it "returns the parameter if the number is higher" do
      5.sanity_check_max(2).should == 2
    end

    it "doesn't change anything if the number is equal" do
      5.sanity_check_max(5).should == 5
    end

    it "returns the number if the number is lower" do
      5.sanity_check_max(7).should == 5
    end
  end
end
