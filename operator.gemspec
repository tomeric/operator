$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'bundler'
require 'operator/version'

Gem::Specification.new do |gem|
  gem.name    = "operator"
  gem.version = Operator::VERSION

  gem.summary     = "Subscribe and publish to a transmitter server with ease."
  gem.description = "Subscribe and publish to a transmitter server with ease."

  gem.authors  = ["Tom-Eric Gerritsen"]
  gem.email    = "tomeric@eet.nu"
  gem.homepage = "http://github.com/tomeric/operator"

  gem.files = Dir["{lib,spec}/**/*", "README*", "LICENSE*"]

  gem.add_dependency "railties",      ">= 3.0"
  gem.add_dependency "activesupport", ">= 3.0"
  gem.add_dependency "json",          ">=1.8.3"
  gem.add_dependency "httparty"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "jeweler"
  gem.add_development_dependency "yard"
  gem.add_development_dependency "rspec", "~> 2.0"
  gem.add_development_dependency "fakeweb"
end
