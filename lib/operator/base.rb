module Operator
  class Base
    def self.notification_server=(uri)
      @@notification_server = uri
    end
    
    def self.notification_server
      defined?(@@notification_server) ? @@notification_server : nil
    end
    
    def self.api_key=(api_key)
      @@api_key = api_key
    end
    
    def self.api_key
      defined?(@@api_key) ? @@api_key : nil
    end
  end
end
