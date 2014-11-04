require "nutella/core_ext/module"

INIT_ARGS = %i[a b c]
INIT_INSTANCE_VARS = INIT_ARGS.map { |arg| arg.to_s.prepend("@").to_sym }

INIT_VALUES = [0] * INIT_ARGS.size

class InitTest
  initializer *INIT_ARGS
end

class InitBlockTest
  initializer *INIT_ARGS do
    @block_run = true
  end

  def block_run?
    @block_run
  end
end
