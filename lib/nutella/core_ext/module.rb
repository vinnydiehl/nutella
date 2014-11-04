class Module
  # A DRYer way to create a constructor where all of its arguments are assigned
  # to instance variables of the same name.
  #
  # @example Comparison of constructor creation with and without Nutella
  #   # Pure Ruby
  #   class Test
  #     def initialize(a, b, c, d)
  #       @a, @b, @c, @d = a, b, c, d
  #     end
  #   end
  #   Test.new(0, 0, 0, 0).instance_variables # => [:@a, :@b, :@c, :@d]
  #
  #   # Ruby with Nutella
  #   class Test
  #     initializer *%i[a b c d]
  #   end
  #   Test.new(0, 0, 0, 0).instance_variables # => [:@a, :@b, :@c, :@d]
  #
  #   # It can also take a block with additional code to run
  #   class Test
  #     initializer :a, :b do
  #       @in_block = 0
  #     end
  #   end
  #   Test.new(0, 0).instance_variables # => [:@a, :@b, :@in_block]
  #
  # @param [Array] args the names of the arguments to the constructor as symbols
  # @yield code to be executed on construction
  def initializer(*args, &block)
    define_method :initialize do |*input|
      (input.last.is_a?(Hash) \
       ? input[-1]
       : Hash[args.zip input]).each do |name, value|
        instance_variable_set "@#{name}", value
      end

      instance_eval(&block) if block_given?
    end
  end
end
