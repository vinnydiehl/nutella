require File.expand_path("../lib/nutella/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name = "nutella"
  gem.version = Nutella::VERSION

  gem.author = "Vinny Diehl"
  gem.email = "vinny.diehl@gmail.com"
  gem.homepage = "https://github.com/vinnydiehl/nutella"

  gem.license = "MIT"

  gem.summary = "Spread some Nutella on Ruby to sweeten up its functionality."
  gem.description = "My collection of Ruby utilities, mainly core extensions."

  gem.require_paths = %w[lib]
  gem.test_files = Dir["spec/**/*"]
  gem.files = Dir["lib/**/*"] + gem.test_files + %w[
    .rspec LICENSE Rakefile README.md nutella.gemspec
  ]

  gem.required_ruby_version = "~> 2.0"
  gem.add_development_dependency "fuubar", "~> 2.0"
  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency "redcarpet", "~> 2.2"
  gem.add_development_dependency "rdoc", "~> 3.12"
  gem.add_development_dependency "rspec", "~> 3.1"
  gem.add_development_dependency "yard", "~> 0.8"
end
