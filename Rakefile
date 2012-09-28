require "nutella/version"

require "bundler"
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new :spec
task test: :spec

require "yard"
YARD::Rake::YardocTask.new do |doc|
  doc.files << "lib/**/*.rb"
  doc.options << ["--title", "Nutella #{Nutella::VERSION} Documentation"]
end
task doc: :yard

task default: :spec
