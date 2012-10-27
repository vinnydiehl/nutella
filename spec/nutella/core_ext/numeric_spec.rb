require "spec_helper"
require "nutella/core_ext/numeric"

describe Numeric do
  describe "aliases" do
    # Test the singular aliases- byte for bytes, kilobyte for kilobytes, etc.
    ([""] + %w[kilo mega giga tera peta exa]).each do |prefix|
      test_alias Numeric, (name = "#{prefix}byte").to_sym, "#{name}s".to_sym
    end
  end
end
