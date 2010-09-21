require 'operator'
require 'rails'

module Operator
  class Railtie < ::Rails::Railtie
    # The to_prepare block is executed once in production env and before every
    # request in development. It's the perfect place to (re)load subscribers.
    config.to_prepare do
      subscriber_path = Rails.root.join('app', 'processors', '**', '*.rb').to_s      
      Dir[subscriber_path].each do |subscriber|
        require subscriber
      end
    end
  end
end
