module Operator
  class Base
    class_attribute :notification_server
    class_attribute :api_key
    class_attribute :logger
    
    def self.configure(hash)
      self.notification_server = hash[:notification_server]
      self.api_key             = hash[:api_key]
      self.logger              = hash[:logger]
    end
    
    def notification_server
      self.class.notification_server || Operator::Base.notification_server
    end
    
    def api_key
      self.class.api_key || Operator::Base.api_key
    end
    
    def logger
      self.class.logger || Operator::Base.logger || Logger.new(STDOUT)
    end
  end
end
