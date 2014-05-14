Spree::CheckoutController.class_eval do
 
  ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)
 
 
end