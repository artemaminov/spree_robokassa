module Spree
  CheckoutController.class_eval do

    before_filter :redirect_to_robokassa, :only => :update

    private

    def redirect_to_robokassa
      return unless params[:state] == "payment"
      return unless params[:order][:payments_attributes]

      payment_method = Spree::PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
      if payment_method && payment_method.kind_of?(Spree::BillingIntegration::Robokassa)
        @order.update_attributes(object_params)
        redirect_to robokassa_path(:order_id => @order.id, :payment_method_id => payment_method.id)
      end

    end


  end
end