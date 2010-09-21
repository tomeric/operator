Rails::Application.routes.draw do
  post "operator/:queue" => "operator/messages#create", :as => :process_message
end
