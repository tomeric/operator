$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'bundler'
require 'operator/version'

Gem::Specification.new do |gem|
  gem.name    = "operator"
  gem.version = Operator::VERSION
  
  gem.summary     = "Subscribe and publish to a transmitter server with ease."
  gem.description = "Subscribe and publish to a transmitter server with ease."
  
  gem.authors  = ["Tom-Eric Gerritsen"]
  gem.email    = "tomeric@i76.nl"
  gem.homepage = "http://github.com/tomeric/operator"
  
  gem.files = Dir["{lib,spec}/**/*", "README*", "LICENSE*"] & `git ls-files -z`.split("\0")

  gem.add_bundler_dependencies
end