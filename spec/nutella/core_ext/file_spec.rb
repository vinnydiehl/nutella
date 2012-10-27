require "spec_helper"
require "nutella/core_ext/file"
require "nutella/core_ext/numeric"

describe File do
  describe "::human_size" do
    context "when given a Numeric" do
      it "does not change bytes" do
        File.human_size(150.bytes).should == "150 Bytes"
      end

      it "changes kilobytes" do
        File.human_size(1.5.kilobytes).should == "1.5 KB"
      end

      it "changes megabytes" do
        File.human_size(1.5.megabytes).should == "1.5 MB"
      end

      it "changes gigabytes" do
        File.human_size(1.5.gigabytes).should == "1.5 GB"
      end

      it "rounds down properly to the tenths" do
        File.human_size(1.72.megabytes).should == "1.7 MB"
      end

      it "rounds up properly to the tenths" do
        File.human_size(1.78.megabytes).should == "1.8 MB"
      end

      it "has a singular unit for 1 byte" do
        File.human_size(1.byte).should == "1 Byte"
      end

      it "returns 'Empty' for an empty file or a blank parameter" do
        File.human_size(0).should == "Empty"
        File.human_size(nil).should == "Empty"
      end

      it "displays whole numbers without a decimal" do
        File.human_size(1.megabyte).should == "1 MB"
        File.human_size(24.gigabytes).should == "24 GB"
      end
    end

    context "when given a File" do
      it "detects empty files properly" do
        begin
          f = File.new("temp", "w")
          File.human_size(f).should == "Empty"
        ensure
          File.delete "temp"
        end
      end

      it "detects the file size properly" do
        begin
          File.truncate(f = File.new("temp", "w"), 1.5.kilobytes)
          File.human_size(f).should == "1.5 KB"

          File.truncate(f = File.new("temp", "w"), 3.kilobytes)
          File.human_size(f).should == "3 KB"
        ensure
          File.delete "temp"
        end
      end
    end

    context "when given a String" do
      it "detects the file size properly" do
        begin
          File.truncate(f = File.new("temp", "w"), 1.5.kilobytes)
          File.human_size("temp").should == "1.5 KB"

          File.truncate(f = File.new("temp", "w"), 3.kilobytes)
          File.human_size("temp").should == "3 KB"
        ensure
          File.delete "temp"
        end
      end
    end
  end

  describe "#human_size" do
    it "detects empty files properly" do
      begin
        File.new("temp", "w").human_size.should == "Empty"
      ensure
        File.delete "temp"
      end
    end

    it "detects the file size properly" do
      begin
        File.truncate(f = File.new("temp", "w"), 1.5.kilobytes)
        f.human_size.should == "1.5 KB"

        File.truncate(f = File.new("temp", "w"), 3.kilobytes)
        f.human_size.should == "3 KB"
      ensure
        File.delete "temp"
      end
    end
  end
end
