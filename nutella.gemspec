require File.expand_path("../lib/nutella/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name = "nutella"
  gem.version = Nutella::VERSION

  gem.author = "Vinny Diehl"
  gem.email = "gbchaosmaster926@gmail.com"
  gem.homepage = "https://github.com/gbchaosmaster/nutella"

  gem.license = "MIT"

  gem.summary = "Spread some Nutella on Ruby to sweeten up its functionality."
  gem.description = "My collection of Ruby utilities, mainly core extensions."

  gem.require_paths = %w[lib]
  gem.test_files = Dir["spec/**/*"]
  gem.files = Dir["lib/**/*"] + gem.test_files + %w[
    .rspec LICENSE Rakefile README.md nutella.gemspec
  ]

  gem.required_ruby_version = ">= 1.9.2"
  gem.add_development_dependency "rake", "~> 0.9"
  gem.add_development_dependency "redcarpet", "~> 2.1"
  gem.add_development_dependency "rspec", "~> 2.11"
  gem.add_development_dependency "yard", "~> 0.8"
end
