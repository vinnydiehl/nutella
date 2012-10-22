require "spec_helper"
require "nutella/core_ext/object"

describe Object do
  describe "#blank?" do
    it "should be blank when nil" do
      nil.blank?.should be_true
    end

    it "should be blank when false" do
      false.blank?.should be_true
    end

    it "should not be blank when true" do
      true.blank?.should be_false
    end

    it "should not be blank when numeric" do
      [0, 1].each { |n| n.blank?.should be_false }
    end

    context "when a string" do
      it "should be blank if the string is empty" do
        "".blank?.should be_true
      end

      it "should be blank if only whitespace" do
        ["  ", "\n  \t"].each { |str| str.blank?.should be_true }
        "  something here  ".blank?.should be_false
      end

      it "should not be blank if the string has content" do
        "string".blank?.should be_false
      end
    end

    context "when a collection" do
      it "should be blank if the collection is empty" do
        [[], {}].each { |collection| collection.blank?.should be_true }
      end

      it "should not be blank if there are elements in the collection" do
        [[1, 2, 3], { 1 => 2, 3 => 4 }].each do |collection|
          collection.blank?.should be_false
        end
      end
    end
  end

  describe "#present?" do
    it "should be the inverse of #blank?" do
      [0, 1].each { |n| n.present?.should be_true }
      [[], {}].each { |collection| collection.present?.should be_false }
      ["", "  "].each { |str| str.present?.should be_false }
      ["str", "  str "].each { |str| str.present?.should be_true }
    end
  end

  describe "#presence" do
    it "should return the object if the object is present" do
      1.presence.should == 1
      "str".presence.should == "str"
    end

    it "should return nil if the object is not present" do
      "".presence.should be_nil
      false.presence.should be_nil
    end
  end
end
