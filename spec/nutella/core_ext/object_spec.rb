require "spec_helper"
require "nutella/core_ext/object"

describe Object do
  describe "aliases" do
    test_alias Object, :is_an?, :is_a?
  end

  describe "#blank?" do
    it "is blank when nil" do
      expect(nil).to be_blank
    end

    it "is blank when false" do
      expect(false).to be_blank
    end

    it "is not blank when true" do
      expect(true).not_to be_blank
    end

    it "is not blank when numeric" do
      [0, 1].each { |n| expect(n).not_to be_blank }
    end

    context "when a string" do
      it "is blank if the string is empty" do
        expect("").to be_blank
      end

      it "is blank if only whitespace" do
        ["  ", "\n  \t"].each { |str| expect(str).to be_blank }
        expect("  something here  ").not_to be_blank
      end

      it "is not blank if the string has content" do
        expect("string").not_to be_blank
      end
    end

    context "when a collection" do
      it "is blank if the collection is empty" do
        [[], {}].each { |collection| expect(collection).to be_blank }
      end

      it "is not blank if there are elements in the collection" do
        [[1, 2, 3], { 1 => 2, 3 => 4 }].each do |collection|
          expect(collection).not_to be_blank
        end
      end
    end
  end

  describe "#present?" do
    it "is the inverse of #blank?" do
      [0, 1].each { |n| expect(n).to be_present }
      [[], {}].each { |collection| expect(collection).not_to be_present }
      ["", "  "].each { |str| expect(str).not_to be_present }
      ["str", "  str "].each { |str| expect(str).to be_present }
    end
  end

  describe "#presence" do
    it "returns the object if the object is present" do
      expect(1.presence).to eq(1)
      expect("str".presence).to eq("str")
    end

    it "returns nil if the object is not present" do
      expect("".presence).to be_nil
      expect(false.presence).to be_nil
    end
  end
end
