require 'spec_helper'

describe Operator::Base do
  describe "inheritance" do
    before(:each) do
      @previous_values = Operator::Base.notification_server, Operator::Base.api_key, Operator::Base.logger
      
      Operator::Base.notification_server = 'http://localhost'
      Operator::Base.api_key = 'the_api_key_is_awesome'
      
      class InheritedOperatorBase < Operator::Base
      end
    end 
    
    after(:each) do
      Object.send :remove_const, :InheritedOperatorBase
      Operator::Base.notification_server, Operator::Base.api_key, Operator::Base.logger = @previous_values
    end    

    it "copies the notification_server when inherited" do
      InheritedOperatorBase.notification_server.should eql(Operator::Base.notification_server)
    end
    
    it "copies the api_key when inherited" do
      InheritedOperatorBase.api_key.should eql(Operator::Base.api_key)
    end
  end
  
  describe "class methods" do
    describe "configure" do
      before(:each) do
        @previous_values = Operator::Base.notification_server, Operator::Base.api_key, Operator::Base.logger
      end

      after(:each) do
        Operator::Base.notification_server, Operator::Base.api_key, Operator::Base.logger = @previous_values
      end
      
      it "sets the notification server" do
        Operator::Base.configure(:notification_server => 'http://localhost:3000', :api_key => 'the_api_key_is_awesome')
        Operator::Base.notification_server.should eql('http://localhost:3000')
      end
      
      it "sets the api key" do
        Operator::Base.configure(:notification_server => 'http://localhost:3000', :api_key => 'the_api_key_is_awesome')
        Operator::Base.api_key.should eql('the_api_key_is_awesome')
      end
    end
  end
  
  describe "instance methods" do
    before(:each) do
      @previous_values = Operator::Base.notification_server, Operator::Base.api_key, Operator::Base.logger
      Operator::Base.configure(:notification_server => 'http://localhost:3000', :api_key => 'the_api_key_is_awesome')
      @instance = Operator::Base.new
    end

    after(:each) do
      Operator::Base.notification_server, Operator::Base.api_key, Operator::Base.logger = @previous_values
    end

    describe "notification_server" do
      it "returns the notification_server" do
        @instance.notification_server.should eql('http://localhost:3000')
      end
      
      it "returns Operator::Base's notification_server on inheritance" do
        class InheritedOperatorBase < Operator::Base
          self.notification_server = nil
        end
        
        InheritedOperatorBase.new.notification_server.should eql('http://localhost:3000')
      end
    end
    
    describe "api_key" do
      it "returns the api_key" do
        @instance.api_key.should eql('the_api_key_is_awesome')
      end
      
      it "returns Operator::Base's api_key on inheritance" do
        class InheritedOperatorBase < Operator::Base
          self.api_key = nil
        end
        
        InheritedOperatorBase.new.api_key.should eql('the_api_key_is_awesome')
      end
    end
  end
end
