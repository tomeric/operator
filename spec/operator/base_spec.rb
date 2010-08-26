require 'spec_helper'

describe Operator::Base do
  describe "inheritance" do
    before(:each) do
      @previous_values = Operator::Base.notification_server, Operator::Base.api_key
      
      Operator::Base.notification_server = 'http://localhost'
      Operator::Base.api_key = 'the_api_key_is_awesome'
    
      class InheritedOperatorBase < Operator::Base
      end
    end 
    
    after(:each) do
      Object.send :remove_const, :InheritedOperatorBase
      Operator::Base.notification_server, Operator::Base.api_key = @previous_values
    end    

    it "copies the notification_server when inherited" do
      InheritedOperatorBase.notification_server.should eql(Operator::Base.notification_server)
    end
    
    it "copies the api_key when inherited" do
      InheritedOperatorBase.api_key.should eql(Operator::Base.api_key)
    end
  end
end
