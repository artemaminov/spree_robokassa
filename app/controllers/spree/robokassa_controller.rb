module Spree
  class RobokassaController < Spree::CheckoutController
    require 'active_merchant'
    require 'active_merchant/billing/integrations/action_view_helper'
    ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)

    before_filter :find_payment
    before_filter :create_notification

    skip_before_filter :verify_authenticity_token, :only => [:result, :success, :fail]
    skip_before_filter :check_authorization, :only => [:result]
    ssl_required :show

    def show
      ActiveMerchant::Billing::Base.integration_mode = @payment_method.mode
      if @order.blank? || @payment_method.blank?
        flash[:error] = I18n.t("invalid_arguments")
        redirect_to :back
      else
        render :action => :show
      end
    end

    def result
      if @order && @payment_method && @notification.acknowledge
        #payment = @order.payments.create(
        #    amount: params["OutSum"].to_f,
        #    payment_method_id: @order.available_payment_methods.first.id)
        ## Need to force checkout to complete state
        #until @order.state == "complete"
        #  if @order.next!
        #    @order.update!
        #    state_callback(:after)
        #  end
        #end
        render :text => @notification.success_response
        #render :text => "OK#{@order.id}"
      else
        #payment.failure!
        render :text => "Invalid Signature"
      end
    end

    def success
      if @order && @payment_method && @notification.acknowledge && @order.complete?
        session[:order_id] = nil
        redirect_to order_path(@order), :notice => I18n.t("payment_success")
      else
        flash[:error] =  t("payment_fail")
      end
    end

    def fail
      flash[:error] = t("payment_fail")
      redirect_to @order.blank? ? root_url : checkout_state_path("payment")
    end

    private

    def find_payment
      robokassa_payment_method = Spree::PaymentMethod.find_by_type('Spree::BillingIntegration::Robokassa')
      @payment_method = @order.available_payment_methods.detect{|x| x.id == robokassa_payment_method.id }
    end

    def create_notification
      @notification = @payment_method.provider_class::Notification.new(request.raw_post, :secret => @payment_method.preferred_password2)
    end


  end
end