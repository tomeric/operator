module Operator
  class Base
    class_inheritable_accessor :notification_server
    class_inheritable_accessor :api_key
    
    def self.configure(hash)
      self.notification_server = hash[:notification_server]
      self.api_key             = hash[:api_key]
    end
    
    def notification_server
      self.class.notification_server || Operator::Base.notification_server
    end
    
    def api_key
      self.class.api_key || Operator::Base.api_key
    end
  end
end
