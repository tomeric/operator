require 'spec_helper'

describe Operator::Base do
  describe "class methods" do
    describe "#notification_server=" do
      before(:each) do
        @previous_notification_server = Operator::Base.send(:class_variable_get, :@@notification_server) rescue nil
      end
      
      after(:each) do
        Operator::Base.send(:class_variable_set, :@@notification_server, @previous_notification_server)
      end
      
      it "sets the notification_server class variable" do
        Operator::Base.notification_server = 'http://localhost'
        Operator::Base.send(:class_variable_get, :@@notification_server).should eql('http://localhost')
      end
    end
    
    describe "#notification_server" do
      before(:each) do
        @previous_notification_server = Operator::Base.send(:class_variable_get, :@@notification_server) rescue nil
        Operator::Base.send(:class_variable_set, :@@notification_server, 'http://localhost')
      end
      
      after(:each) do
        Operator::Base.send(:class_variable_set, :@@notification_server, @previous_notification_server)
      end

      it "gets the notification_server class variable" do
        Operator::Base.notification_server.should eql('http://localhost')
      end
    end
    
    describe "#api_key=" do
      before(:each) do
        @previous_api_key = Operator::Base.send(:class_variable_get, :@@api_key) rescue nil
      end

      after(:each) do
        Operator::Base.send(:class_variable_set, :@@api_key, @previous_api_key)
      end

      it "sets the api_key class variable" do
        Operator::Base.api_key = 'http://localhost'
        Operator::Base.send(:class_variable_get, :@@api_key).should eql('http://localhost')
      end
    end

    describe "#api_key" do
      before(:each) do
        @previous_api_key = Operator::Base.send(:class_variable_get, :@@api_key) rescue nil
        Operator::Base.send(:class_variable_set, :@@api_key, 'http://localhost')
      end

      after(:each) do
        Operator::Base.send(:class_variable_set, :@@api_key, @previous_api_key)
      end

      it "gets the api_key class variable" do
        Operator::Base.api_key.should eql('http://localhost')
      end
    end
  end
end
