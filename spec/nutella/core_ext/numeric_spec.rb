require "spec_helper"
require "nutella/core_ext/numeric"

describe Numeric do
  describe "aliases" do
    # Test the singular aliases- byte for bytes, kilobyte for kilobytes, etc.
    ([""] + %w[kilo mega giga tera peta exa]).each do |prefix|
      test_alias Numeric, (name = "#{prefix}byte").to_sym, "#{name}s".to_sym
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
