require "spec_helper"
require "nutella/core_ext/file"
require "nutella/core_ext/numeric"

describe File do
  describe "::human_size" do
    context "when given a Numeric" do
      it "does not change bytes" do
        expect(File.human_size(150.bytes)).to eq("150 Bytes")
      end

      it "changes kilobytes" do
        expect(File.human_size(1.5.kilobytes)).to eq("1.5 KB")
      end

      it "changes megabytes" do
        expect(File.human_size(1.5.megabytes)).to eq("1.5 MB")
      end

      it "changes gigabytes" do
        expect(File.human_size(1.5.gigabytes)).to eq("1.5 GB")
      end

      it "rounds down properly to the tenths" do
        expect(File.human_size(1.72.megabytes)).to eq("1.7 MB")
      end

      it "rounds up properly to the tenths" do
        expect(File.human_size(1.78.megabytes)).to eq("1.8 MB")
      end

      it "has a singular unit for 1 byte" do
        expect(File.human_size(1.byte)).to eq("1 Byte")
      end

      it "returns 'Empty' for an empty file or a blank parameter" do
        expect(File.human_size(0)).to eq("Empty")
        expect(File.human_size(nil)).to eq("Empty")
      end

      it "displays whole numbers without a decimal" do
        expect(File.human_size(1.megabyte)).to eq("1 MB")
        expect(File.human_size(24.gigabytes)).to eq("24 GB")
      end
    end

    context "when given a File" do
      it "detects empty files properly" do
        begin
          f = File.new("temp", "w")
          expect(File.human_size(f)).to eq("Empty")
        ensure
          File.delete "temp"
        end
      end

      it "detects the file size properly" do
        begin
          File.truncate(f = File.new("temp", "w"), 1.5.kilobytes)
          expect(File.human_size(f)).to eq("1.5 KB")

          File.truncate(f = File.new("temp", "w"), 3.kilobytes)
          expect(File.human_size(f)).to eq("3 KB")
        ensure
          File.delete "temp"
        end
      end
    end

    context "when given a String" do
      it "detects the file size properly" do
        begin
          File.truncate(f = File.new("temp", "w"), 1.5.kilobytes)
          expect(File.human_size("temp")).to eq("1.5 KB")

          File.truncate(f = File.new("temp", "w"), 3.kilobytes)
          expect(File.human_size("temp")).to eq("3 KB")
        ensure
          File.delete "temp"
        end
      end
    end
  end

  describe "#human_size" do
    it "detects empty files properly" do
      begin
        expect(File.new("temp", "w").human_size).to eq("Empty")
      ensure
        File.delete "temp"
      end
    end

    it "detects the file size properly" do
      begin
        File.truncate(f = File.new("temp", "w"), 1.5.kilobytes)
        expect(f.human_size).to eq("1.5 KB")

        File.truncate(f = File.new("temp", "w"), 3.kilobytes)
        expect(f.human_size).to eq("3 KB")
      ensure
        File.delete "temp"
      end
    end
  end
end
