Spree::CheckoutController.class_eval do

  # require 'active_merchant'
  # require 'active_merchant/billing/integrations/action_view_helper'
  ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)

  before_filter :redirect_to_robokassa, :only => :update

  private

  def redirect_to_robokassa
    return unless params[:state] == "payment"

    payment_method = Spree::PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
    if payment_method && payment_method.kind_of?(Spree::BillingIntegration::Robokassa)
      redirect_to robokassa_path(:shporder_number => @order.number)
    end

  end


end