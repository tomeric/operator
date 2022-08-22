Rails.application.routes.prepend do
  post "operator/:queue" => "operator/messages#create", :as => :process_message
end
