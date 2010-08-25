$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'operator/version'

require 'bundler'

Bundler.setup
Bundler.require :development

require 'rspec/core/rake_task'


task :build do
  system "gem build operator.gemspec"
end

task :install => :build do
  system "gem install operator-#{Operator::VERSION}.gem"
end

task :release => :build do
  puts "Tagging #{Operator::VERSION}..."
  system "git tag -a #{Operator::VERSION} -m 'Tagging #{Operator::VERSION}'"
  
  puts "Pushing to GitHub..."
  system "git push --tags"
  
  puts "Pushing to Rubygems..."
  system "gem push operator-#{Operator::VERSION}.gem"
  
  puts "All done!\n"
end

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

RSpec::Core::RakeTask.new('spec:progress') do |spec|
  spec.spec_opts = %w(--format progress)
  spec.pattern = "spec/**/*_spec.rb"
end

YARD::Rake::YardocTask.new

task :default => ["spec"]
