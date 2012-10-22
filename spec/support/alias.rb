# Tests if +method_a+ is an alias to +method_b+ in the class +cls+.
def test_alias(cls, method_a, method_b)
  describe "##{method_a.to_s}" do
    it "should be an alias of ##{method_b.to_s}" do
      cls.instance_method(method_a).should === cls.instance_method(method_b)
    end
  end
end
