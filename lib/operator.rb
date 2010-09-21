$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'json'
require 'httparty'
require 'active_support/core_ext'

module Operator #:nodoc
end

require 'operator/version'
require 'operator/base'
require 'operator/publisher'
require 'operator/processor'

if defined?(Rails)
  if Rails::VERSION::MAJOR == 3
    require 'operator/railtie'
    require 'operator/engine'
  else
    Rails.logger.debug "Only Ruby on Rails 3 is supported by the operator gem"
  end
end

$LOAD_PATH.shift
