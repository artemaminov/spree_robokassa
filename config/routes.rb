Spree::Core::Engine.routes.draw do

  get '/checkout/robokassa/:order_number' => 'robokassa#show', :as => :robokassa
  get '/checkout/robokassa/result' => 'robokassa#result', :as => :robokassa_result
  get '/checkout/robokassa/success' => 'robokassa#success', :as => :robokassa_success
  get '/checkout/robokassa/fail' => 'robokassa#fail', :as => :robokassa_fail

end
