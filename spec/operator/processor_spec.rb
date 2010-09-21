require 'spec_helper'

describe Operator::Processor do
  
  describe "class methods" do
    describe "#subscribes_to" do
      before(:each) do
        @previous_queue = Operator::Processor.queue rescue nil
      end
      
      after(:each) do
        Operator::Processor.queue = @previous_queue
      end
      
      it "sets the queue" do
        Operator::Processor.subscribes_to :queue_name
        Operator::Processor.queue.should eql('queue_name')
      end  
    end
    
    describe "#subscribers" do
      before(:each) do
        class CreatedUserProcessor < Operator::Processor
        end
        
        class CreatedAwesomeUserProcessor < CreatedUserProcessor
        end
      end
      
      after(:each) do
        Object.send(:remove_const, :CreatedUserProcessor)
        Object.send(:remove_const, :CreatedAwesomeUserProcessor)
      end
      
      it "does not include Operator::Processor" do
        Operator::Processor.subscribers.should_not include(Operator::Processor)
      end
      
      it "includes the class that inherited from Operator::Processor" do
        Operator::Processor.subscribers.should include(CreatedUserProcessor)
      end
      
      it "includes the class that inherited from a class that was inherited from Operator::Processor" do
        Operator::Processor.subscribers.should include(CreatedAwesomeUserProcessor)
      end
    end
    
    describe "#subscribers_for" do
      before(:each) do
        class CreatedUserProcessor < Operator::Processor
          subscribes_to :created_users
        end
        
        class CreatedArticleProcessor < Operator::Processor
          subscribes_to :created_articles
        end
        
        class CreatedAwesomeUserProcessor < CreatedUserProcessor
        end
      end

      after(:each) do
        Object.send(:remove_const, :CreatedUserProcessor)
        Object.send(:remove_const, :CreatedArticleProcessor)
        Object.send(:remove_const, :CreatedAwesomeUserProcessor)
      end
      
      it "includes the Processor that subscribed to the given queue" do
        Operator::Processor.subscribers_for(:created_users).should include(CreatedUserProcessor)
      end

      it "includes the Processor that inherited from a subscriber that subscribed to the given queue" do
        Operator::Processor.subscribers_for(:created_users).should include(CreatedAwesomeUserProcessor)
      end
      
      it "does not include the Processor that did not subscribe to the given queue" do
        Operator::Processor.subscribers_for(:created_users).should_not include(CreatedArticleProcessor)
      end
    end
    
    describe "#process" do
      before(:each) do
        class CreatedUserProcessor < Operator::Processor
          subscribes_to :created_users
        end
      end
      
      after(:each) do
        Object.send(:remove_const, :CreatedUserProcessor)
      end
      
      it "initializes a processor" do
        processor = Operator::Processor.process('{}')
        processor.should be_an_instance_of(Operator::Processor)
      end
      
      it "initializes a inherited processor" do
        processor = CreatedUserProcessor.process('{}')
        processor.should be_an_instance_of(CreatedUserProcessor)
      end
      
      it "deserializes the JSON message" do
        processor = Operator::Processor.process('{"key":"value"}')
        processor.message['key'].should eql('value')
      end
      
      it "processes the message" do
        processor = mock(Operator::Processor, :message => {})
        Operator::Processor.stub(:new).and_return(processor)
        
        processor.should_receive(:process)
        CreatedUserProcessor.process('{}')
      end
    end
  end
end
