module Operator
  class Publisher < Base    
    attr_accessor :message
    class_attribute :queue
    
    def self.publishes_to(queue)
      self.queue = queue.to_s
    end
    
    def publish
      response = HTTParty.post(
        endpoint,
        :body => { 
          :notification => { :message => message_as_json, :queue => self.class.queue }
        }
      )

      notification = response.parsed_response
      
      if notification['message'] == message_as_json
        return true
      else
        raise notification.inspect
      end
    end
    
    def message_as_json
      response = JSON.dump(message)
    end
    
    def endpoint
      raise "please set #{self.class}.notification_server or Operator::Base.notification_server first" unless notification_server
      raise "please set #{self.class}.api_key or Operator::Base.api_key first"                         unless api_key
      
      "#{notification_server}/notifications.json?api_key=#{api_key}"    
    end
  end
end
