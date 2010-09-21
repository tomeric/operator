$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'json'
require 'httparty'
require 'active_support/core_ext'

require 'operator/version'
require 'operator/base'
require 'operator/publisher'
require 'operator/processor'

$LOAD_PATH.shift
