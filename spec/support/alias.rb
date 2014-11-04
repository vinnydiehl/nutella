# Tests if +method_a+ is an alias to +method_b+ in the class +cls+.
def test_alias(cls, method_a, method_b)
  describe "##{method_a.to_s}" do
    it "is an alias of ##{method_b.to_s}" do
      expect(cls.instance_method method_a).to eq(cls.instance_method(method_b))
    end
  end
end
