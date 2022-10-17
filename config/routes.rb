if Operator::Engine.respond_to?(:routes)
  Operator::Engine.routes.draw do
    post ':queue' => 'operator/messages#create', :as => :process_message
  end
else
  Rails.application.routes.prepend do
    post 'operator/:queue' => 'operator/messages#create', :as => :process_message
  end
end
