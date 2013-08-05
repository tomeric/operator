$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'operator'
require 'rspec'
require 'logger'

Operator::Base.logger = Logger.new('log/test.log')

RSpec.configure do |config|
end
