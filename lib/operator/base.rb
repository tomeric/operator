module Operator
  class Base
    class << self
      attr_accessor :notification_server
      attr_accessor :api_key
    end
  end
end
