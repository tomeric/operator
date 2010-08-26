require 'spec_helper'

describe Operator::Publisher do
  before(:each) do
    @publisher = Operator::Publisher.new
  end
  
  describe "class methods" do
    describe "#publishes_to" do
      before(:each) do
        @previous_queue = Operator::Publisher.queue rescue nil
      end
      
      after(:each) do
        Operator::Publisher.queue = @previous_queue
      end
      
      it "sets the queue as a string" do
        Operator::Publisher.publishes_to :queue_name
        Operator::Publisher.queue.should eql('queue_name')
      end
    end   
  end
  
  describe "instance methods" do
    describe "#endpoint" do      
      it "raises an error if the notification server is unknown" do
        lambda {
          @publisher.endpoint
        }.should raise_error(/set Operator::Publisher.notification_server or Operator::Base.notification_server first/)
      end
      
      it "raises an error if the API key is unknown" do
        @publisher.class.stub(:notification_server).and_return('http://localhost:3000')
        
        lambda {
          @publisher.endpoint
        }.should raise_error(/set Operator::Publisher.api_key or Operator::Base.api_key first/)
      end
      
      it "returns a proper endpoint that includes the notification server and the API key" do
        @publisher.class.stub(:notification_server).and_return('http://localhost:3000')
        @publisher.class.stub(:api_key).and_return('the-api-key-is-awesome')
        
        @publisher.endpoint.should eql('http://localhost:3000/notifications.json?api_key=the-api-key-is-awesome')
      end
    end
    
    describe "#message_as_json" do
      it "returns the JSON that is sent to the notification server" do
        @publisher.stub(:message).and_return({ :this_is_a => 'hash', :it_is_formatted_as => 'json' })
        @publisher.message_as_json.should eql('{"this_is_a":"hash","it_is_formatted_as":"json"}')
      end      
    end
    
    describe "#publish!" do
      before(:each) do
        @endpoint     = 'http://localhost:3000/notifications.json?api_key=the-api-key-is-awesome'
        @json_message = '{"hello":"world"}'
        @queue        = :the_queue
        
        @publisher.class.publishes_to @queue
        @publisher.stub(:endpoint).and_return(@endpoint)
        @publisher.stub(:message_as_json).and_return(@json_message)        
      end
      
      after(:each) do
        @publisher.class.publishes_to nil
      end
      
      def succesful_response
        mock('response', :parsed_response => { "message" => @json_message })
      end
      
      def unsuccesful_response
        mock('response', :parsed_response => { "queue" => "can't be blank" })
      end
          
      it "sends a POST to the Publisher's endpoint with correct notification attributes" do        
        HTTParty.should_receive(:post).with(
          @endpoint,
          :body => { :notification => { :message => @json_message, :queue => 'the_queue' } }
        ).and_return(succesful_response)
        
        @publisher.publish!
      end
      
      it "returns true if the POST is succesful" do
        HTTParty.stub(:post).and_return(succesful_response)
        @publisher.publish!.should be_true
      end
      
      it "raises an error if the POST is unsuccesful" do
        HTTParty.stub(:post).and_return(unsuccesful_response)
        lambda {
          @publisher.publish!
        }.should raise_error
      end
    end
  end
end
