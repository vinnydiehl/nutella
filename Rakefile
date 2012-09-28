require "bundler"
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new :spec
task test: :spec

require "rdoc/task"
Rake::RDocTask.new do |rd|
  rd.rdoc_dir = "doc"
  rd.rdoc_files.include "lib/**/*.rb"
end
task doc: :rdoc

task default: :spec
