Spree::Core::Engine.routes.draw do

    get '/robokassa/:payment_method_id/:order_id' => 'robokassa#show', :as => :robokassa
    get '/robokassa/result' => 'robokassa#result', :as => :robokassa_result
    get '/robokassa/success' => 'robokassa#success', :as => :robokassa_success
    get '/robokassa/fail' => 'robokassa#fail', :as => :robokassa_fail

end
