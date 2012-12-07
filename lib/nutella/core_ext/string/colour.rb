class String
  colours = %w[black red green yellow blue magenta cyan white]
  colours.concat colours.map { |c| "light#{c}" }
  colours.each_with_index do |colour, i|
    define_method(colour) { "\e[38;5;#{i}m#{self}\e[0m" }
  end
end
