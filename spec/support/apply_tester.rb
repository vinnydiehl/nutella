class ApplyTester
  attr_accessor :value

  def initialize(start_value)
    @value = start_value
  end
end

def increment_value(tester, amount = 1, extra_arg = 0)
  tester.value += amount + extra_arg
end
