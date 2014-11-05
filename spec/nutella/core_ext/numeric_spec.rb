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

  describe "#to_currency" do
    context "when used with no options" do
      it "returns a USD style string with 2 decimals precision" do
        expect(5.to_currency).to eq("$5.00")
        expect(5.25.to_currency).to eq("$5.25")
      end

      it "rounds properly" do
        expect(5.254.to_currency).to eq("$5.25")
        expect(5.255.to_currency).to eq("$5.26")
      end

      it "uses ',' as a thousands separator" do
        expect(5000.to_currency).to eq("$5,000.00")
        expect(5e6.to_currency).to eq("$5,000,000.00")
        expect(5e5.to_currency).to eq("$500,000.00")
        expect(5e4.to_currency).to eq("$50,000.00")
      end
    end

    context "when using pretty mode" do
      it "strips decimals from whole numbers" do
        expect(1.to_currency pretty: true).to eq("$1")
        expect(1.to_currency pretty: true).to eq("$1")
      end

      it "keeps decimals if there are any cents" do
        expect(1.01.to_currency pretty: true).to eq("$1.01")
        expect(1.20.to_currency pretty: true).to eq("$1.20")
        expect(1.21.to_currency pretty: true).to eq("$1.21")
      end

      it "only checks cents out to the hundredths" do
        expect(5.004.to_currency pretty: true).to eq("$5")
        expect(5.005.to_currency pretty: true).to eq("$5.01")
      end
    end

    it "has an adjustable sign" do
      expect(5.to_currency sign: "£").to eq("£5.00")
    end

    it "has adjustable unit separator and thousands delimiters" do
      expect(5.to_currency separator: ",").to eq("$5,00")
      expect(5e3.to_currency separator: ",", delimiter: ".").to eq("$5.000,00")
    end

    it "has adjustable sign position" do
      expect(5000.5.to_currency sign: " €", position: :right,
                             separator: ",", delimiter: " ").
        to eq("5 000,50 €")
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
