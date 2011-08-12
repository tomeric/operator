module Operator
  class Processor
    attr_accessor :message
    class_attribute :queue
    
    def initialize(message)
      self.message = message
    end
    
    def self.subscribes_to(queue)
      self.queue = queue.to_s
    end
    
    def self.subscribers(direct = false)
      classes = []
      
      ObjectSpace.each_object(Class) do |c|
        classes << c if c.ancestors.include?(self) && (c != self)
      end

      classes.uniq
    end
    
    def self.subscribers_for(queue)
      queue = queue.to_s
      
      subscribers.find_all do |subclass|
        subclass.queue == queue
      end
    end
    
    def self.process(json_message)
      parsed_message = JSON.parse(json_message)
      
      processor = new(parsed_message)
      processor.process
      
      processor
    end
    
    def process
    end
  end
end
