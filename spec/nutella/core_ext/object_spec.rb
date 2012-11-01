require "spec_helper"
require "nutella/core_ext/object"

describe Object do
  describe "aliases" do
    test_alias Object, :is_an?, :is_a?
  end

  describe "#blank?" do
    it "is blank when nil" do
      nil.should be_blank
    end

    it "is blank when false" do
      false.should be_blank
    end

    it "is not blank when true" do
      true.should_not be_blank
    end

    it "is not blank when numeric" do
      [0, 1].each { |n| n.should_not be_blank }
    end

    context "when a string" do
      it "is blank if the string is empty" do
        "".should be_blank
      end

      it "is blank if only whitespace" do
        ["  ", "\n  \t"].each { |str| str.should be_blank }
        "  something here  ".should_not be_blank
      end

      it "is not blank if the string has content" do
        "string".should_not be_blank
      end
    end

    context "when a collection" do
      it "is blank if the collection is empty" do
        [[], {}].each { |collection| collection.should be_blank }
      end

      it "is not blank if there are elements in the collection" do
        [[1, 2, 3], { 1 => 2, 3 => 4 }].each do |collection|
          collection.should_not be_blank
        end
      end
    end
  end

  describe "#present?" do
    it "is the inverse of #blank?" do
      [0, 1].each { |n| n.should be_present }
      [[], {}].each { |collection| collection.should_not be_present }
      ["", "  "].each { |str| str.should_not be_present }
      ["str", "  str "].each { |str| str.should be_present }
    end
  end

  describe "#presence" do
    it "returns the object if the object is present" do
      1.presence.should == 1
      "str".presence.should == "str"
    end

    it "returns nil if the object is not present" do
      "".presence.should be_nil
      false.presence.should be_nil
    end
  end
end
