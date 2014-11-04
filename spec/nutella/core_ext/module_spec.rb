require "spec_helper"
require "nutella/core_ext/module"

describe Module do
  describe "initializer" do
    it "defines the instance variables" do
      expect(InitTest.new *INIT_VALUES).
        to have_instance_variables(*INIT_INSTANCE_VARS)
    end

    context "with a block" do
      let!(:t) { InitBlockTest.new *INIT_VALUES }

      it "defines the instance variables" do
        expect(t).to have_instance_variables(*INIT_INSTANCE_VARS)
      end

      it "runs the block" do
        expect(t.block_run?).to be true
      end
    end
  end
end
