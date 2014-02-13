Spree::Core::Engine.routes.draw do

  post '/checkout/robokassa/result' => 'robokassa#result', :as => :robokassa_result
  post '/checkout/robokassa/success' => 'robokassa#success', :as => :robokassa_success
  post '/checkout/robokassa/fail' => 'robokassa#fail', :as => :robokassa_fail
  get '/checkout/robokassa/:order_number' => 'robokassa#show', :as => :robokassa

end
