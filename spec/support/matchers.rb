RSpec::Matchers.define :have_instance_variables do |*vars|
  match do |target|
    (vars - target.instance_variables).empty?
  end

  failure_message do |target|
    "expected #{target.inspect} to have all of the following instance variables: " +
    "\n  #{vars.inspect}" +
    "\nInstead it contains:\n  #{target.instance_variables.inspect}"
  end

  failure_message_when_negated do |target|
    "expected #{target.inspect} to not have any of the following instance variables: " +
    "\n  #{vars.inspect}" +
    "\nIt contains:\n  #{target.instance_variables.inspect}"
  end
end
