module Operator
  class Publisher < Base    
    attr_accessor :message
    
    def self.publishes_to(queue)
      @@queue = queue
    end

    def self.queue
      defined?(@@queue) ? @@queue.to_s : nil
    end
    
    def publish!
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
      raise "please set #{self.class}.notification_server first" unless self.class.notification_server
      raise "please set #{self.class}.api_key first"             unless self.class.api_key
      
      "#{self.class.notification_server}/notifications.json?api_key=#{self.class.api_key}"    
    end
  end
end
