Dir["#{File.dirname __FILE__}/core_ext/*.rb"].each do |file|
  require "nutella/core_ext/#{File.basename file, ".rb"}"
end
