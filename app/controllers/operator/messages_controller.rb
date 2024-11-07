module Operator
  class MessagesController < ActionController::API

    ##
    # POST /operator/:queue
    #
    # Find all the matching `Processor`s and let them process the message in
    # `params[:message]`.
    #
    # If no `Processor` can be found, a 404 will be raised.
    #
    # If any of the `Processor`s raise an exception, a 500 error will be
    # raised and the processing wilt stop immediately
    def create
      processors = Processor.subscribers_for(params[:queue])

      if processors.empty?
        head :not_found
        return
      end

      processors.each do |processor|
        processor.process(params[:message])
      end

      head :ok
    end
  end
end
